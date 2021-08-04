# Linux

Add a new user: `sudo adduser -aG sudo [USER]`

List groups of current user: `groups [USER]`

List all groups: `getent groups`

Remove group: `groupdel [GROUP]`

Add group: `groupadd [GROUP]`

Add user to group: `sudo usermod -aG [GROUP](, [GROUP]) [USER]`

Remove user from group: `sudo gpasswd -d [USER] [GROUP]

Create shared folder for group:
```bash
mdkir [DIRECTORY]
# set group permission for a directory
sudo chgrp [GROUP] [DIRECTORY]
# set read, write, execute permission for root and group, and permit usage for all other users
chmod 770 [DIRECTORY]
# inherit file permissions to all subdirectories
sudo chmod +s [DIRECTORY]
```
