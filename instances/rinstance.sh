#!/bin/sh

##
## This script is NOT a good example!!
##     e.g., containing hard coded variables
##

## These environment variables shall be removed from here and specified in the shell that launches this script.
export RAILS_ENV="production"
export MYAPP_DATABASE_PASSWORD="<password>"
export SECRET_TOKEN="<secret-token>" 

## The following variable may be moved to arguments of this script.
REPOS_APPNAME="yourapp"

## Kill the running instance
kill `cat ri.pid`

cd $REPOS_APPNAME

## Run the rails server
bundle exec rails server &

## Save the PID if rails server and watch this shell process until the rails server goes down
PID=$!
cd ..
echo $PID > ri.pid

RET=0
while [ $RET -eq 0 ];
do
	kill -0 $PID
	RET=$?
	sleep 1
done
