# docker_gui_demo
Configuring a container to connect to its host's X11 display server.
A container is typically used to run background/cli apps, but there are cases for running containerized GUI apps such as for machine vision.

## Build and run
clone, cd then call docker build
```
docker build . -t gimp:0.0
./run_gimp_ctr.sh
```
dont forget to chmod +x the script

## How it works
This demo is runs a containerized instance of ```gimp``` and configures it to connect to the host's X11 display server. Most of the information here is a summary of the links listed under Resources and is meant for my own personal notes.

An app needs to know 3 things to open a window
1. How to communicate with display server(X11)
2. How to authenticate
3. Where to display the window

### Communicating with X11
X11 communicates using unix sockets, and runs a server on the host. Since a container runs in isolation, specify
```
--net host
``` 
to allow the container to use the host's network.

The unix socket exists as a file on the host, so we bind mount the socket to the container using 
```
-v /tmp/.X11-unix:/tmp/.X11-unix
```
Here we allowed the host's x11 socket to be mounted to the container.

### Authentication
Look into Resources for more indepth details.
In this demo mounting ```Xauthority``` from host to container is chosen, as it is portable and doesn't allow unfettered access.
Basically, Xauthority contains all the authentication details used for the current user session. This information is bind mounted to the container to allow it access to the same credentials.
```
-v $XAUTHORITY:/tmp/.Xauthority
```
In the Dockerfile, specify the XAUTHORITY environment variable to use the path the folder was mounted to. In this example, it is ```ENV XAUTHORITY /tmp/.Xauthority```

### Where to display
X11 needs to know which display to draw the window in. Run ```echo $DISPLAY``` and copy that value to the Dockerfile. Here it is ```ENV DISPLAY :1```

## Resources
https://janert.me/blog/2022/running-a-gui-application-in-a-docker-container1/

https://www.howtogeek.com/devops/how-to-run-gui-applications-in-a-docker-container/

https://wiki.ros.org/docker/Tutorials/GUI

