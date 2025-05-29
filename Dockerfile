FROM python:3.9

RUN apt-get update && \
    apt-get install -y openssh-server && \
    mkdir /var/run/sshd && \
    echo 'root:sshpass' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config

COPY requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

COPY device_diag.py /device_diag.py
RUN mkdir /diagnostics

EXPOSE 2222
CMD ["/usr/sbin/sshd", "-D"]
