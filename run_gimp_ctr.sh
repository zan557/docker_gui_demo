#!/bin/sh

docker run -it --rm -v /tmp/.X11-unix:/tmp/.X11-unix -v $XAUTHORITY:/tmp/.Xauthority --network host --name gimp gimp:0.0

