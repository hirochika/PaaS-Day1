#!/bin/sh

## Working repository
WORKING_REPOSITORY=/home/cloud/gitolite-admin

## Arguments
repository=$1
username=$2

## Only one process is allowed
[ -f /tmp/create_repository.lock ] && exit 1

## Lock
touch /tmp/create_repository.lock
trap 'rm -f /tmp/create_repository.lock' 1 2

## Check the argument
if [ "$repository" = "" ];
then
	printf "%s <repository> <username>\n" $0
	echo "Error: Please specify repository"
	rm -f /tmp/create_repository.lock
	exit 1
fi
if [ "$username" = "" ];
then
	printf "%s <repository> <username>\n" $0
	echo "Error: Please specify username"
	rm -f /tmp/create_repository.lock
	exit 1
fi

cd $WORKING_REPOSITORY
if [ ! -f keydir/$username.pub ];
then
	echo "Error: User not found."
	exit 1
fi
echo "
repo    $username/$repository
        RW+     =   admin
        RW      =   $username
        R       =   instance" >> conf/gitolite.conf
git commit -m "Add $repository." -a
git push

sudo sh -c "echo \"#!/bin/sh

## Username/Repository
REPOSITORY=\\\"$username/$repository\\\"
\" > /var/lib/gitolite/repositories/$username/$repository.git/hooks/post-update"
sudo sh -c "cat ~/rails_git_post_update_hook.sh >> /var/lib/gitolite/repositories/$username/$repository.git/hooks/post-update"
sudo chown git /var/lib/gitolite/repositories/$username/$repository.git/hooks/post-update
sudo chmod +x /var/lib/gitolite/repositories/$username/$repository.git/hooks/post-update

## Unlock
rm -f /tmp/create_repository.lock

