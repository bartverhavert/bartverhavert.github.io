---
title: I2C on your Raspberry Pi
categories: development, raspberry pi
kind: article
created_at: 2017-04-01
---
<!-- preview_start -->

Meh

<!-- preview_end -->

### Enable I2C

To enable userspace access to I2C ensure that `/etc/modules` contains the following line:
```
i2c-dev
```

### Install wiringPI

https://learn.sparkfun.com/tutorials/raspberry-gpio/c-wiringpi-setup

# SSH

Run following command to generate a new ssk key pair if none is existing yet.
```
ssh-keygen
```
The default location is ok. Enter a password if asked.

Run following command to get the generated key:
```
cat ~/.ssh/id_rsa.pub
```

# Install git

```
sudo apt-get install git
```
