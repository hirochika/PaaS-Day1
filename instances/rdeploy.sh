#!/bin/sh

kill `cat ri.pid`
rm -rf myapp
git clone ssh://git@your-repository-server/repository/name

cd myapp
export RAILS_ENV="production"
export MYAPP_DATABASE_PASSWORD="<password>"
bundle install --path vendor/bundle
bundle exec rake db:migrate
