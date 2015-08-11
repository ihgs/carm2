#!/bin/bash
bundle exec rake admin:create_user
bundle exec rake db:mongoid:create_indexes
bundle exec rails s -p 3000 -b '0.0.0.0'
