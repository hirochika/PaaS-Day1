#!/bin/sh

##
## This script is NOT a good example!!
##     e.g., containing hard coded variables
##

## Kill the running instance
kill `cat ri.pid`

## Remove the old software
rm -rf yourapp

## Clone the up-to-date software
git clone ssh://git@your-repository-server/repository/yourapp

## Execute bundle install and DB migration
cd yourapp
export RAILS_ENV="production"
export MYAPP_DATABASE_PASSWORD="<password>"
bundle install --path vendor/bundle
bundle exec rake db:migrate
