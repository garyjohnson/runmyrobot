#!/bin/bash

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade

sudo apt-get -y install python-serial python-dev libgnutls28-dev espeak python-smbus python-pip git

sudo pip install -U socketIO-client &&\

cd ~ &&\

git clone https://github.com/adafruit/Adafruit-Motor-HAT-Python-Library.git &&\
cd Adafruit-Motor-HAT-Python-Library &&\

sudo apt-get -y install python-dev &&\
sudo python setup.py install &&\

cd ~ &&\
wget ftp://ftp.alsa-project.org/pub/lib/alsa-lib-1.0.25.tar.bz2 &&\
tar xjf alsa-lib-1.0.25.tar.bz2 &&\
cd alsa-lib-1.0.25 &&\
./configure --host=arm-unknown-linux-gnueabi &&\
make -j4 &&\
sudo make install &&\

cd ~ &&\
git clone git://git.videolan.org/x264 &&\
cd x264 &&\
./configure --host=arm-unknown-linux-gnueabi --enable-static --disable-opencl &&\
make -j4 &&\
sudo make install &&\

cd ~ &&\
git clone https://github.com/FFmpeg/FFmpeg.git &&\
cd FFmpeg &&\
./configure --arch=armel --target-os=linux --enable-gpl --enable-libx264 --enable-nonfree --extra-libs=-ldl &&\
make -j4 &&\
sudo make install

cd ~
sudo git clone https://github.com/runmyrobot/runmyrobot
cd runmyrobot

sudo cp ~/runmyrobot/scripts/start_robot ~/

sudo crontab -l > /tmp/cron.tmp
sudo echo '@reboot /bin/bash /home/pi/start_robot' >> /tmp/cron.tmp
sudo crontab /tmp/cron.tmp


sudo nano ~/start_robot
