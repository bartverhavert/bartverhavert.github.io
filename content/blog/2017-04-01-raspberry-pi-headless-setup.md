---
title: Raspberry Pi headless setup
categories: development, raspberry, pi, zero, wireless, ssh
tags: nanoc
kind: article
created_at: 2017-03-30
---

<!-- preview_start -->

This is a Mac guide that will walk you through the steps you have to take to get Raspbian Jessie
Lite up and running on your Raspberry Pi. It is mainly written for the Raspberry
Pi Zero W, which doesn't have an ethernet port and because I didn't have a mini-HDMI
cable, but it should work for the other ones as well.

<!-- preview_end -->

### Install Raspbian

* Download the latest version of [Raspbian](https://www.raspberrypi.org/downloads/raspbian/ "Raspbian")

* Get yourself an SD card that fits in your Raspberry Pi, for the Zero W this is
a Micro SD card. I use an 8 GB one, which is more than enough for what I'm doing
with it. Format the SD card to **FAT32**.

* Find the location of the SD card on your computer.

~~~
diskutil list
~~~

* Unmount the SD card

~~~
diskutil unmountDisk /dev/disk<#DISK_NUMBER#>
~~~

* Write the image to the SD card

~~~
sudo dd bs=1m if=~/Downloads/<#image_name#>.img of=/dev/rdisk<#DISK_NUMBER#>
~~~


### Enable SSH

In order to be able to perform tasks on your Raspberry Pi, you need SSH. However, since
Raspbian Jessie, this is disabled by default. To enable it at first boot, perform the following
command. Side note, 'boot' is a folder created when writing the image to the SD card, it's also
the only folder you can read and write to from your Mac without doing any other
tricky things.

~~~
touch /Volumes/boot/ssh
~~~


### WiFi

For my Raspberry Pi Zero W, I had to find a way to set up the WiFi without using
a connected keyboard, mouse and monitor. After some searching, I found
[a blog post](https://davidmaitland.me/2015/12/raspberry-pi-zero-headless-setup/)
which I used to get the job done. For me, the following steps were sufficient.

* Insert SD card in your computer, I used a Windows machine for this
* Use an application like 'Paragon ExtFS' for Windows, or just anything that can write to Ext4 Linux partitions
* Edit the file at `etc/network/interfaces` on the mounted disk. Find the following lines of code

~~~
allow-hotplug wlan0
iface wlan0 inet manual
    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
~~~

and replace them by

~~~
auto wlan0
allow-hotplug wlan0
iface wlan0 inet dhcp
    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
~~~

* Next, edit the file at `etc/wpa_supplicant/wpa_supplicant.conf` and add the following block of code

~~~
network={
    ssid="<#NETWORK_NAME#>"
    psk="<#NETWORK_PASSWORD#>"
    proto=RSN
    key_mgmt=WPA-PSK
    pairwise=CCMP
    auth_alg=OPEN
}
~~~

### Security

Next up, security. All Raspbian installations come, by default, with the following
user and password combination. Username: `pi`, password: `raspberry`.\\
In order to change the password, first connect to your Raspberry Pi.

~~~
ssh pi@<#IP_ADDRESS#>
~~~

Run the following command to be prompted for a new password.

~~~
passwd pi
~~~

<!-- ### Hostname

You can also change the hostname of the Raspberry Pi. This is the name you will see on your router in the list of connected devices through DHCP. To do this, enter the following command.

~~~
sudo hostname <#NEW_HOSTNAME#>
~~~

You'll have to reboot after this, otherwise sudo won't work anymore. -->

### All done

Well look at that, you're all done. Your Raspberry Pi is now ready to be used.
