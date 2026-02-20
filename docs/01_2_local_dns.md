# Local mDNS

Multicast DNS (mDNS) on Ubuntu allows devices on a local network to resolve each other's hostnames to IP addresses without a central DNS server.

### Using systemd-resolved

Recent Ubuntu versions (like 24.04) can handle mDNS natively through systemd-resolved without Avahi. 
- Global Enable:

    Edit /etc/systemd/resolved.conf and set MulticastDNS=yes
    LLMNR=no

    Restart
    ```
    sudo systemctl restart systemd-resolved
    ```

    Enable multicast-dns
    ```
    sudo systemctl enable multicast-dns.service
    sudo systemctl start multicast-dns.service
    ```

    Verify mDNS enabled
    ```
    resolvectl status
    ```

- Per-Interface Enable:

    Ensure mDNS is enabled for specific network interfaces using Netplan or by creating an override in /etc/systemd/network/.
- heck Status:
    
    Use resolvectl status to verify if mDNS is active on your links. 

## Setup XRDP for remote desktop access

Installation
```
sudo apt update 
sudo apt install xrdp -y
```

Check
```
sudo systemctl status xrdp
```


## Setup SSH for remote access

```
sudo apt update
sudo apt install ssh
sudo ufw allow 22
```