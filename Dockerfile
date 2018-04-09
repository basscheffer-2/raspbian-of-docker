FROM resin/rpi-raspbian:latest

RUN sudo apt-get clean && sudo apt-get update && sudo apt-get upgrade \
    && apt-get install wget build-essential apt-utils rpi-update\
    && rpi-update

RUN adduser pi --disabled-password  && adduser pi sudo

COPY of_v0.9.8_linuxarmv6l_release.tar.gz /tmp/

# openframeworks
RUN cd /home/pi \
    && mkdir openFrameworks \
    && tar vxfz /tmp/of_v0.9.8_linuxarmv6l_release.tar.gz -C openFrameworks --strip-components 1 \
    && cd /home/pi/openFrameworks/scripts/linux/debian \
    && ./install_dependencies.sh

RUN make Release -C /home/pi/openFrameworks/libs/openFrameworksCompiled/project

CMD /bin/bash