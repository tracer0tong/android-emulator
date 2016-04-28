# Android-emulator

Android-emulator is yet another Docker image with Android SDK and emulator inside (based on tons of other works).

My aims:

  - Make stable and reliable Docker container
  - Put some tools for static analysis inside
  - Implement useful commands to Makefile

Docker image avalaible from [Docker registry].

### Version
0.0.4

### Tech

* [Docker]
* [Android SDK]
* [Apache Ant]

### Installation

Use Docker registry with *latest* tag:

```sh
$ docker pull tracer0tong/android-emulator:latest
$ docker run -d -P --name android tracer0tong/android-emulator 
```
Or use Makefile from repository:

```sh
$ git clone https://github.com/tracer0tong/android-emulator.git android-emulator
$ cd android-emulator
$ make run
$ make ports
Use:
adb kill-server
adb connect 172.17.0.2:32769
or
adb connect 0.0.0.0:32769
$ adb kill-server
$ adb connect 0.0.0.0:32769
* daemon not running. starting it now on port 5037 *
* daemon started successfully *
connected to 0.0.0.0:32769
$ adb devices
List of devices attached
0.0.0.0:32769   device

$ adb shell
root@generic_x86:/ #
```
By default it will create and run API 19 (arm) for you, but some other versions also supported. You can run emulator for API versions: 19, 21, 22 x86/armeabi-v7a (as -a option). This is the [most popular] API versions among usable devices.

```sh
$ make EMULATOR="android-22" ARCH="x86" run
```
or
```sh
$ docker run -e "EMULATOR=android-22" -e "ARCH=x86" -d -P --name android tracer0tong/android-emulator
```

### How to connect to emulator

Emulator container exposed 4 port's by default:
tcp/22 - SSH connection to container (login: root, password: android, change this if you are security concerned)

* tcp/5037 - ADB
* tcp/5554 - ADB
* tcp/5555 - ADB connection port
* tcp/5900 - QEMU VNC connection (doesn't support pointing device and keyboard, I recommend to use MonkeyRunner for pointing simulation or 3rd-party VNC server pushed into emulator)

Q: How to understand, which ip address use to connect?

A: Depend on Docker toolset: for GUI tools as Kitematic just check port forwardind settings on container home page. If you are using Docker under Linux environment, just use docker ps command.

```sh
$ sudo docker ps
CONTAINER ID        IMAGE                          COMMAND                  CREATED             STATUS              PORTS                                                                                                                       NAMES
0dd15cd1bd43        tracer0tong/android-emulator   "/entrypoint.sh -e an"   6 days ago          Up 6 days           0.0.0.0:32812->22/tcp, 0.0.0.0:32811->5037/tcp, 0.0.0.0:32810->5554/tcp, 0.0.0.0:32809->5555/tcp, 0.0.0.0:32808->5900/tcp   android
$ ssh root@0.0.0.0 -p 32812
root@0.0.0.0's password:
Welcome to Ubuntu 12.04.5 LTS (GNU/Linux 3.19.0-28-generic x86_64)

 * Documentation:  https://help.ubuntu.com/

The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

root@0dd15cd1bd43:~#
```

### Makefile

Additional Makefile targets:

```sh
$ make kill
$ make ps
$ make ports
$ make clean
```

### Todo's

 - Add new targets to Makefile (create new AVD, update sdk etc.)
 - Optimize Dockerfile
 - Provide options for emulator, port redirection, etc.
 - Add androguard, drozer etc. to image

License
----

Apache

[Docker registry]:https://registry.hub.docker.com/u/tracer0tong/android-emulator/
[Docker]:https://www.docker.com
[Android SDK]:https://developer.android.com/sdk/index.html
[Apache Ant]:http://ant.apache.org
[most popular]:https://developer.android.com/about/dashboards/index.html?utm_source=suzunone


