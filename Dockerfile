FROM rockylinux:9

ENV EPICS_BASE /opt/EPICS/epics-base
ENV EPICS_BASE_VERSION R7.0.3.1
ENV PATH /opt/EPICS/epics-base/bin/linux-x86_64:$PATH

RUN mkdir /opt/EPICS

RUN dnf update -y && \
    dnf install -y git readline-devel libstdc++ gcc gcc-c++ cmake openssl-devel perl python3-devel vim iproute tcpdump tmux

# install EPICS
RUN cd /opt/EPICS && \
    git clone --branch $EPICS_BASE_VERSION --recursive https://github.com/epics-base/epics-base.git && \
    make -C epics-base

RUN ln -s /usr/bin/python3 /usr/bin/python

# Install p4p
RUN pip install numpy p4p pyepics

COPY . /opt/EPICS

CMD ["tail", "-f", "/dev/null"]
