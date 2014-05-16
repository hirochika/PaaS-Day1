#!/bin/sh

## Working repository
WORKING_REPOSITORY=/home/ubuntu/gitolite-admin

## Arguments
username=$1
ssh_pub_key=$2

## Only one process is allowed
[ -f /tmp/create_user.lock ] && exit 1

## Lock
touch /tmp/create_user.lock
trap 'rm -f /tmp/create_user.lock' 1 2

## Check the argument
if [ "$username" = "" ];
then
	printf "%s <username> <ssh_pub_key>\n" $0
	echo "Error: Please specify username"
	rm -f /tmp/create_user.lock
	exit 1
fi
if [ "$ssh_pub_key" = "" ];
then
	printf "%s <username> <ssh_pub_key>\n" $0
	echo "Error: Please specify SSH public key"
	rm -f /tmp/create_user.lock
	exit 1
fi

cd $WORKING_REPOSITORY
if [ -f keydir/$username.pub ];
then
	echo "Error: User already exists."
	exit 1
fi
echo "$ssh_pub_key" > keydir/$username.pub
git add keydir/$username.pub
git commit -m "Add $username."
git push

## Unlock
rm -f /tmp/create_user.lock
