all:
	docker build -q -t tracer0tong/android-emulator\:latest .
	docker images

run:
	docker run -d -P --name android --log-driver=json-file tracer0tong/android-emulator
fwd_adb_ports:
	ip=`docker run tracer0tong/android-emulator /bin/bash -c '/sbin/ifconfig eth0 | grep \'inet addr:\' | cut -d: -f2 | awk \'{ print $1}\'`
	echo $ip
	ssh -L 5556:localhost:5554 -L 5557:localhost:5555 root@$(ip)

fwd_adb_ports_b2d:
	echo $( boot2docker ip )

clean:
	docker ps -a -q | xargs -n 1 -I {} docker rm {}
	docker rmi -f $$( docker images | grep "<none>" | awk '{print($$3)}' )

kill:
	docker kill android