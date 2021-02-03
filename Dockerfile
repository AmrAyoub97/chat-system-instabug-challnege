# Dockerfile.rails
FROM ruby:2.6

RUN apt-get update && \
    apt-get install -y nodejs \
                       vim \
                       default-mysql-client &&\
    rm -rf /var/lib/mysql/* &&\
    rm -rf /var/lib/apt/lists/*

ENV APP_ROOT /app
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT
ADD Gemfile $APP_ROOT/Gemfile
ADD Gemfile.lock $APP_ROOT/Gemfile.lock
RUN bundle update --bundler
RUN bundle install
ADD . $APP_ROOT

EXPOSE  3000
CMD rails db:migrate:reset  && rm -f tmp/pids/server.pid && rails s -p 3000 -b '0.0.0.0'