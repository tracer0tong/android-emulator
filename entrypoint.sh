#!/bin/bash

while [[ $# > 1 ]]
do
key="$1"

case $key in
    -e|--emulator)
    EMULATOR="$2"
    shift
    ;;
    -a|--arch)
    ARCH="$2"
    shift
    ;;
    --default)
    DEFAULT=YES
    shift
    ;;
    *)
    echo "Use \"-e android-19 -a x86\" to start Android emulator for API19 on X86 architecture.\n"
    ;;
esac
shift
done
echo EMULATOR  = "Requested API: ${EMULATOR} (${ARCH}) emulator."
if [[ -n $1 ]]; then
    echo "Last line of file specified as non-opt/last argument:"
    tail -1 $1
fi

# Run sshd
/usr/sbin/sshd
adb start-server

# Detect ip and forward ADB ports outside to outside interface
ip=$(ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')
socat tcp-listen:5037,bind=$ip,fork tcp:127.0.0.1:5037 &
socat tcp-listen:5554,bind=$ip,fork tcp:127.0.0.1:5554 &
socat tcp-listen:5555,bind=$ip,fork tcp:127.0.0.1:5555 &

# Set up and run emulator
if [[ $ARCH == *"x86"* ]]
then 
    EMU="x86"
else
    EMU="arm"
fi

echo "no" | /usr/local/android-sdk/tools/android create avd -f -n test -t ${EMULATOR} --abi default/${ARCH}
echo "no" | /usr/local/android-sdk/tools/emulator64-${EMU} -avd test -noaudio -no-window -gpu off -verbose -qemu -usbdevice tablet -vnc :0
