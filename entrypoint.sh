#!/bin/bash

/usr/sbin/sshd
/usr/local/android-sdk/tools/emulator-x86 -avd test -noaudio -no-window -gpu off -verbose -qemu -usbdevice tablet -vnc :0 &
echo "Emulator runned!"