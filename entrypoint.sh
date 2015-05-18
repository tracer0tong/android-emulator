#!/bin/bash

/usr/sbin/sshd
ip=$(ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')
socat tcp-listen:5554,bind=$ip,fork tcp:127.0.0.1:5554 &
socat tcp-listen:5555,bind=$ip,fork tcp:127.0.0.1:5555 &
# Set up and run emulator
echo "n" | android create avd -f -n test -t android-19
/usr/local/android-sdk/tools/emulator-x86 -avd test -noaudio -no-window -gpu off -verbose -qemu -usbdevice tablet -vnc :0
