# Vagrant

## SSH access

By default the vagrant machine can be accessed via `vagrant ssh [HOSTNAME]`. Via following script the password can adjusted set for the root user.

```bash
# enable ssh password authentication
echo "[Task 1] Enable ssh password authentication"
sed -i 's/^PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
systemctl reload sshd

# set root password
echo "[TASK 2] Set root password"
echo -e "[PASSWORD]\n[PASSWORD]" | passwd root >/dev/null 2>&1
```

## Libvirt provider

When using libvirt as a provider for vagrant the DNS may not be working out of the box. To check if there is an issue run `journalctl -u systemd-resolved -f` to view its logs. A log like following suggests to disable DNSSEC, as enabled `DNSSEC` in `/etc/systemd/resolved.conf` will break DNS resolution when upstream DNS servers don't support it:
```txt
systemd-resolved[472]: DNSSEC validation failed for question ntp.ubuntu.com.localdomain IN AAAA: incompatible-server
```

This can be fixed by running this code snippet at boot time.
```bash
# set DNS (e.g. Google's DNS)
sudo resolvectl dns eth0 8.8.8.8
if grep -q '^DNSSEC=yes$' /etc/systemd/resolved.conf; then
  sudo sed -i 's/^DNSSEC=yes$/DNSSEC=no/' /etc/systemd/resolved.conf
fi
sudo systemctl restart systemd-resolved
```
