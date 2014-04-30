#!/bin/sh

##
## This script is NOT a good example!!
##     e.g., containing hard coded variables
##

## Kill the running instance
kill `cat ri.pid`

cd yourapp
export RAILS_ENV="production"
export MYAPP_DATABASE_PASSWORD="<password>"
export SECRET_TOKEN="<secret-token>" 

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
