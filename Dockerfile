FROM ubuntu
ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY :1
ENV XAUTHORITY /tmp/.Xauthority
RUN apt-get update && apt-get install -y gimp
RUN apt-get install -y xauth
CMD ["gimp"]



