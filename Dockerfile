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
CMD rm -f tmp/pids/server.pid && bundle exec rails s -b '0.0.0.0' && rails db:migrate:reset && rails db:seed && bundle exec sidekiq