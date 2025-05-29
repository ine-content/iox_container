# Use Ubuntu 22.04 base image
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies and SSH
RUN apt-get update && \
    apt-get install -y python3 python3-pip openssh-server curl git && \
    mkdir /var/run/sshd && \
    echo 'root:ioxlab' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config

# Copy Python requirements and install
COPY requirements.txt /requirements.txt
RUN pip3 install --upgrade pip && \
    pip3 install -r /requirements.txt

# Optional startup script
COPY bootstrap.sh /bootstrap.sh
RUN chmod +x /bootstrap.sh

EXPOSE 2222
CMD ["/usr/sbin/sshd", "-D"]
