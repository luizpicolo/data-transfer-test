FROM ruby:2.7.1

RUN apt-get update && apt-get install -y
RUN apt-get install -y nodejs sqlite3
RUN apt-get install npm -y

WORKDIR /code
COPY . /code

RUN cd public && npm install
RUN cd ..
RUN bundle install

EXPOSE 4567

CMD ["bundle", "exec", "puma", "-p", "4567"]