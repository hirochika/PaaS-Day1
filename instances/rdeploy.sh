#!/bin/sh

##
## This script is NOT a good example!!
##     e.g., containing hard coded variables
##

## These environment variables shall be removed from here and specified in the shell that launches this script.
export RAILS_ENV="production"
export MYAPP_DATABASE_PASSWORD="<password>"

## The following variables may be moved to arguments of this script.
REPOS_SERVER="your-repository-server"
REPOS_USERNAME=${$1:-"username"}
REPOS_APPNAME=${$2:-"yourapp"}

## Kill the running instance
kill `cat ri.pid`

## Remove the old software
rm -rf $REPOS_APPNAME

## Clone the up-to-date software
git clone ssh://git@$REPOS_SERVER/$REPOS_USERNAME/$REPOS_APPNAME

## Execute bundle install and DB migration
cd $REPOS_APPNAME
bundle install --path vendor/bundle
bundle exec rake db:migrate
