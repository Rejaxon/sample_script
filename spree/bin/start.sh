#!/bin/sh
# export RACK_ENV=production
bundle exec unicorn_rails -c config/unicorn.rb -p 2000 -D