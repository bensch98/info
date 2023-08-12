## Hacking

### Port Scanning

```bash
sudo apt-get install nmap arp-scan
# general port scan
nmap <target_ip>
# ARP scan
arp-scan --interface <network_interface> -l
```

### File Meta Data

```bash
sudo apt-get install libimage-exiftool-perl poppler-utils
pdfinfo <example.pf>
exiftool <example.jpg>
```
