#!/bin/sh
# export RACK_ENV=production
bundle exec unicorn -c config/unicorn.rb -p 2000