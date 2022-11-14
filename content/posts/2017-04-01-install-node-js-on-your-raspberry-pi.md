---
title: Install Node.js on your Raspberry Pi
date: 2017-04-01
draft: true
---
<!-- preview_start -->

This is a Mac guide that will walk you through the steps you have to take to get Node.js up and running on your Raspberry Pi. It is mainly written for the Raspberry Pi Zero W, but it should work for the other ones as well.

<!-- preview_end -->

### Installation

First check what type of processor you have on your Raspberry Pi. For the Zero W this is an ARM11 processor, which is one of the ARMv6 family. This is important to know for selecting the correct Node.js distribution. Look for the version you want on the [distribution website](https://nodejs.org/dist/), I used the `node-v7.7.1-linux-armv6l.tar.gz` one.

To install your distribution, run the following commands. Please make sure all references to the .tar.gz file are changed to your version.

~~~
wget https://nodejs.org/dist/latest-v7.x/node-v7.7.3-linux-armv6l.tar.gz
tar -xvf node-v7.7.1-linux-armv6l.tar.gz
cd node-v7.7.1-linux-armv6l
sudo cp -R * /usr/local/
rm node-v7.7.1-linux-armv6l.tar.gz
rm -r node-v7.7.1-linux-armv6l
~~~

After this, run `node -v` and `npm -v` to verify Node.js and NPM are installed. You can now start writing your awesome Node.js applications like you're used to.

### Keep alive

~~~
sudo npm install pm2 -g
~~~

~~~
sudo pm2 startup
~~~

~~~
sudo pm2 start some-app.js --name "some-name" --watch
~~~

~~~
sudo pm2 save
~~~
