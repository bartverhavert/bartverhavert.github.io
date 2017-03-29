---
title: Raspberry Pi headless setup
categories: development, raspberry, pi, zero, wireless, ssh
tags: nanoc
kind: article
created_at: 2017-04-01
---

<!-- preview_start -->

This guide will walk you through the steps you have to take to get Raspbian Jessie
Lite up and running on your Raspberry Pi. It is mainly written for the Raspberry
Pi Zero W, which doesn't have an ethernet port and because I didn't have a mini-HDMI
cable, but it should work for the other ones as well.

<!-- preview_end -->

# Raspberry Pi installation guide

### Install Raspbian

1. Download the latest version of [Raspbian](https://www.raspberrypi.org/downloads/raspbian/ "Raspbian")

2. Format the SD card to FAT32

3. Find the SD card
```
diskutil list
```

4. Unmount the SD card
```
diskutil unmountDisk /dev/disk<#DISK_NUMBER#>
```

5. Write the image to the disk
```
sudo dd bs=1m if=~/Downloads/<#image_name#>.img of=/dev/rdisk<#DISK_NUMBER#>
```

### Enable SSH
Enable SSH by default which has been disabled in the latest versions of Raspbian
```
touch /Volumes/boot/ssh
```

### WiFi
Setup WiFi on RPIs that don't have an Ethernet port but a WiFi chip instead. (source: https://davidmaitland.me/2015/12/raspberry-pi-zero-headless-setup/)
1. Insert SD card in Windows
2. Use an application like 'Paragon ExtFS', something that can write to Ext4 Linux partitions
3. Edit the file at `etc/network/interfaces` on the mounted disk.
```
allow-hotplug wlan0
iface wlan0 inet manual
    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
```
```
auto wlan0
allow-hotplug wlan0
iface wlan0 inet dhcp
    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
```
4. Next, edit the file at `etc/wpa_supplicant/wpa_supplicant.conf` and add the following block of code
```
network={
	ssid="<#NETWORK_NAME#>"
	psk="<#NETWORK_PASSWORD#>"
	proto=RSN
	key_mgmt=WPA-PSK
	pairwise=CCMP
	auth_alg=OPEN
}
```

### Security
Boot up your Raspberry Pi and connect to it through ssh.
```
ssh pi@<#IP_ADDRESS#>
```
The default password is `raspberry`, change this to whatever you want by entering the following command.
```
passwd pi
```

### Hostname
You can also change the hostname of the Raspberry Pi. This is the name you will see on your router in the list of connected devices through DHCP. To do this, enter the following command.
```
sudo hostname <#NEW_HOSTNAME#>
```
You'll have to reboot after this, otherwise sudo won't work anymore.

### All done
Your Raspberry Pi is now ready to be used, you should be able to access it through SSH over WiFi.
