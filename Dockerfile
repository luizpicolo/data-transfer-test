FROM node:22-bookworm AS node

FROM ruby:3.2-bookworm

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV RACK_ENV=production \
    RAILS_ENV=production \
    TZ=America/Campo_Grande

# Node.js e npm
COPY --from=node /usr/local/bin/node /usr/local/bin/node
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules

# Dependências do sistema
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        curl \
        build-essential \
        sqlite3 \
        libsqlite3-dev \
        cron \
        gnupg \
        ca-certificates \
        tzdata \
        git \
    && rm -rf /var/lib/apt/lists/*

# Yarn Classic
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
    && ln -s /usr/local/lib/node_modules/npm/bin/npx-cli.js /usr/local/bin/npx \
    && npm install --global yarn@1.22.22

# Speedtest CLI
RUN curl -fsSL \
        https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh \
        -o /tmp/install-speedtest.sh \
    && bash /tmp/install-speedtest.sh \
    && apt-get update \
    && apt-get install -y --no-install-recommends speedtest \
    && rm -f /tmp/install-speedtest.sh \
    && rm -rf /var/lib/apt/lists/*

RUN ln -snf "/usr/share/zoneinfo/$TZ" /etc/localtime \
    && echo "$TZ" > /etc/timezone \
    && mkdir -p /db

WORKDIR /code

COPY Gemfile Gemfile.lock ./
RUN bundle install
RUN cd /code/public && yarn install

COPY . .

RUN cd public && yarn install --frozen-lockfile

EXPOSE 4567

RUN printf '%s\n' \
    'SHELL=/bin/sh' \
    'PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin' \
    '*/10 * * * * cd /code && RACK_ENV=production RAILS_ENV=production /usr/local/bin/bundle exec rake rate:save >> /proc/1/fd/1 2>> /proc/1/fd/2' \
    > /tmp/app-cron \
    && crontab /tmp/app-cron \
    && rm /tmp/app-cron

CMD ["bundle", "exec", "ruby", "app.rb", "-o", "0.0.0.0", "-p", "4567"]