# PaaS (B2) Day 1
This project is for a PBL lecture course (B2) about cloud computing at the University of Tokyo.

## Source code list

* instances: a set of scripts placed to the LXC container template
** rdeploy.sh: deploy script
** rinstance.sh: rails server launch script
* repository: a set of scripts placed to the repository
** rails_git_post_update_hook.sh: post-update hook to be copied to each repository
** create_user.sh: shell script to create a user
** create_repository.sh: shell script to create a repository
* http-load-balancer: a script placed to the HTTP load balancer
** nginx_autoconfig.sh: configuration script for nginx
