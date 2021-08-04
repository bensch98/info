# Linux

### User management:
```bash
# add new user
sudo useradd [USER]

# list users
cat /etc/passwd

# make user sudo
sudo usermod -aG sudo [USER]
sudo visudo /etc/sudoers # add user
```


*sudoers*
```text
#
# This file MUST be edited with the 'visudo' command as root.
#
# Please consider adding local content in /etc/sudoers.d/ instead of
# directly modifying this file.
#
# See the man page for details on how to write a sudoers file.
#
Defaults	env_reset
Defaults	mail_badpass
Defaults	secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"

# Host alias specification

# User alias specification

# Cmnd alias specification

# User privilege specification
root	ALL=(ALL:ALL) ALL

# Members of the admin group may gain root privileges
%admin ALL=(ALL) ALL
############ ADD SUDO USER HERE ############
########## username ALL=(ALL) ALL ##########

# Allow members of group sudo to execute any command
%sudo	ALL=(ALL:ALL) ALL

# See sudoers(5) for more information on "#include" directives:

#includedir /etc/sudoers.d
```


### Group management:
```bash
# add group
groupadd [GROUP]

# delete group
groupdel [GROUP]

# list groups of current user
groups [USER]

# list all groups
getent groups

# add user to group
sudo usermod -aG [GROUP](,[GROUP]) [USER]

# remove user from group
sudo gpasswd -d [USER] [GROUP]

```


### File permissions:
```text
4 -> r
2 -> w
1 -> x

Add up for combined permissions
7 -> rwx ...

-rwxrwxrwx
1: d -> directory, - -> file
2-4: rwx -> owner permissions
5-7: rwx -> group permissions
8-10: rwx -> all user permissions
```


### Create shared folder for group:
```bash
mdkir [DIRECTORY]

# set group permission for a directory
sudo chgrp [GROUP] [DIRECTORY]

# set rwx permission for root and group, and permit usage for all other users
chmod 770 [DIRECTORY]

# inherit file permissions to all subdirectories
sudo chmod +s [DIRECTORY]
```
