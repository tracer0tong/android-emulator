all:
	docker build -q -t tracer0tong/android-emulator\:latest .
	docker images

run:
	docker run -d -P --name android --log-driver=json-file tracer0tong/android-emulator

fwd_adb_ports_b2d:
	echo $( boot2docker ip )

clean:
	docker ps -a -q | xargs -n 1 -I {} docker rm {}
	list=$$( docker images | grep "<none>" | awk '{print($$3)}' )
	echo $$list
	if [ -n "$$list" ]; then docker rmi -f $$list; fi

kill:
	docker kill android