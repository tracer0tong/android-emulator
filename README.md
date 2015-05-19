# Android-emulator

Android-emulator is yet another Docker image with Android SDK and emulator inside (based on tons of other works).

My aims:

  - Make stable and reliable Docker container
  - Put some tools for static analysis inside
  - Implement useful commands to Makefile

Docker image avalaible from [Docker registry].

### Version
0.0.2

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
 adb connect 172.17.1.88:33069
or
 adb connect 0.0.0.0:33069
or
 adb connect 192.168.59.103:33069
```
By default it will create and run API 19 (x86) for you, but some other versions also supported. You can run emulator for API versions: 10, 18, 19, 21, 22. This is the most popular API versions among usable devices.

```sh
$ make EMULATOR="android-10" run
```
or
```sh
$ docker run -d -P --name android tracer0tong/android-emulator -e "android-10"
```

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


