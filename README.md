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
```
Or use Makefile from repository:

```sh
$ git clone https://github.com/tracer0tong/android-emulator.git android-emulator
$ cd android-emulator
$ make run
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


