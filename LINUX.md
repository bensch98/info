# Linux

## Rights

### User management

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


### Group management

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


### File permissions

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

## Disk Formatting

### Format Bootable to USB

```bash
sudo fdisk -l
sudo wipefs -f --all /dev/sdx # replace x with name of disk
sudo fdisk -l # check
sudo cfdisk /dev/sdx # create new partition
```
Steps:
1. select dos for drives below 2TB
2. Enter to create new partition
3. leave partition size at default which is the maximum possible
4. select primary
5. select and enter "Write"
6. confirm with yes
7. quit program


### Formt USB Drive with FAT
```bash
# replace x with name of disk
sudo mkfs.vfat -n 'LABEL' /dev/sdx1
```

## Hardware Settings

### Disabling Peripherals

```bash
$ xinput list
⎡ Virtual core pointer                          id=2    [master pointer  (3)]
⎜   ↳ Virtual core XTEST pointer                id=4    [slave  pointer  (2)]
⎜   ↳ MSFT0001:00 06CB:7F28 Mouse               id=16   [slave  pointer  (2)]
⎜   ↳ MSFT0001:00 06CB:7F28 Touchpad            id=17   [slave  pointer  (2)]
⎜   ↳ ITE Tech. Inc. ITE Device(8910) Keyboard  id=13   [slave  pointer  (2)]
⎜   ↳ Logitech MX Master 3                      id=10   [slave  pointer  (2)]
⎣ Virtual core keyboard                         id=3    [master keyboard (2)]
    ↳ Virtual core XTEST keyboard               id=5    [slave  keyboard (3)]
    ↳ Power Button                              id=9    [slave  keyboard (3)]
    ↳ Jabra Link 370                            id=12   [slave  keyboard (3)]
    ↳ AT Translated Set 2 keyboard              id=18   [slave  keyboard (3)]
    ↳ Video Bus                                 id=7    [slave  keyboard (3)]
    ↳ ITE Tech. Inc. ITE Device(8910) Keyboard  id=20   [slave  keyboard (3)]
    ↳ ITE Tech. Inc. ITE Device(8910) Wireless Radio Control    id=14   [slave  keyboard (3)]
    ↳ Power Button                              id=6    [slave  keyboard (3)]
    ↳ Integrated Camera: Integrated C           id=11   [slave  keyboard (3)]
    ↳ Logitech MX Master 3                      id=19   [slave  keyboard (3)]
    ↳ Video Bus                                 id=8    [slave  keyboard (3)]
    ↳ HD 4.50R (AVRCP)                          id=21   [slave  keyboard (3)]
    ↳ Ideapad extra buttons                     id=15   [slave  keyboard (3)]
```

Search for desired id and disable or enable it via following command:

```bash
# enable
xinput set-prop 17 "Device Enabled" 1
# disable
xinput set-prop 17 "Device Enabled" 0
```

In this case the integrated Laptop touchpad was enabled and then disabled.

## Screen Resolution

Really old monitors might not work out of the box on Linux attached to newer hardware. This can easily be fixed by setting the screen resolution directly in GRUB:

```bash
sudo vi /etc/default/grub
# find the line:
# # GRUB_GFXMODE=640x480
# and change it to e.g.:
# GRUB_GFXMODE=1920x1200
sudo update-grub
reboot
```

## Networking

### Ports

Check if port is in use. No output means, that it's not in use yet.
```bash
netstat -na | grep :4000
ss -na | grep :4000
```

Open port via ufw (iptables is old).
```bash
sudo ufw allow 4000
```

Test newly opened port via 2 terminals:
*1st terminal (e.g. 192.168.0.2)*
```bash
sudo ls | nc -l -p 4000
```

*2nd terminal (192.168.209.3)*
```bash
telnet 192.168.0.2 4000
Trying 192.168.0.2...
Connected to 192.168.0.2.

...
```

List open ports:
```bash
# show also locally open ports
netstat -antplF
# or show only open ports to outside
nmap -open 192.168.0.2
```
