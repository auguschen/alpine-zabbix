FROM alpine:3.6
MAINTAINER Chen Augus <tianhao.chen@gmail.com>
# ENV MAINLAND Y
COPY mirrormainland.sh /tmp/mirrormainland.sh
COPY install.sh /tmp/install.sh
COPY startservice.sh /usr/bin/startservice.sh
RUN /tmp/install.sh
EXPOSE 80 443 10050 10051
CMD /usr/bin/startservice.sh
