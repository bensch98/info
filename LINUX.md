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

## Package Management

### Multiple different versions

To manage multiple different versions of a package installed via `apt` the actively used version can be chosen via `update-alternatives`. This is an example to manage version 7, 8 and 9 for both gcc and g++.

```bash
sudo apt-get update
sudo apt-get install build-essential
sudo apt-get -y install gcc-7 g++-7 gcc-8 g++-8 gcc-9 g++-9
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 7
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 7
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 8
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 8
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 9
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 9
sudo update-alternatives --config gcc
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

## Remote Access

### X-Forwarding

To forward the display via X following option must be inserted or uncommented in `/etc/ssh/sshd_config`:
```txt
X11Forwarding yes
```

After that the ssh service must be restarted via:
```bash
sudo systemctl restart ssh
```

Now it should be able to forward the remote display when specifying the `-X` or `-Y` flag in the ssh command.
```bash
ssh -X user@ip
# if you trust the remote PC and want a little better performance use -Y
ssh -Y user@ip
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

### IPv6

Identify network interface name to configure for IPv6 via `ip a`.
Then edit following file or create if not already present:
*/etc/netplan/00-installer-config.yaml*
```yaml
network:
  version: 2
  ethernets:
    <interface_name>:
      dhcp4: <yes/no>
      dhcp6: <yes/no>
      addresses:
      - <IPv6_address>/<prefix_length>
      gateway6: <IPv6_gateway>
      nameservers:
        addresses:
        - <DNS_server_IPv6_address>
        - <DNS_server_IPv6_address>
```

The variables can be set as follows:
- *interface name*: Find out interface name via `ip a` 
- *IPv6 address*: Static IPv6 address that should be assigned
- *prefix length*: Probably /64
- *IPv6 gateway*: `ip -6 route` -> `default via <IPv6_gateway> dev <interface_name>`
- *DNS server IPv6 address*: DNS Server config with

Apply the above configuration via:
```bash
sudo netplan apply
```

Verify that the IPv6 address was configured correctly via `ip a` and ping a well-known IPv6 address like Google's DNS server (2001:4860:4860::8888). 
```bash
ping6 2001:4860:4860::8888
```
