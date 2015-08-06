FROM ruby:2.2.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN apt-get install -y nodejs nodejs-legacy npm
RUN npm install bower -g
RUN mkdir /webapp
WORKDIR /webapp
ADD webapp /webapp
ENV RAILS_ENV=production
RUN bundle install
RUN bundle exec rake bower:install["--allow-root"]
RUN bundle exec rake assets:precompile
RUN bundle exec rake db:mongoid:create_indexes
ADD run_app.sh /run_app.sh
RUN chmod +x /run_app.sh

ENTRYPOINT ["/run_app.sh"]
