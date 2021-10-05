FROM ruby:2.7.1

WORKDIR /code
COPY . /code

RUN cd public && npm install
RUN cd .. && bundle install

EXPOSE 4567

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "4567"]