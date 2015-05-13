all:
	docker build -q -t tracer0tong/android-emulator\:latest .
	docker images

run:
	docker run -d -p 127.0.0.1\:\:5905 -p 127.0.0.1\:\:5554 -p 127.0.0.1\:\:5555 tracer0tong/android-emulator /usr/local/android-sdk/tools/emulator-x86 -avd test -noaudio -no-window -gpu off -verbose -qemu -vnc \:5
	docker ps
