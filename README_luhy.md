docker build -t android_luhy .
docker run -d -P --name androidgui_luhy -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix android_luhy
