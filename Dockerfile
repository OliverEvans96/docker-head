FROM ubuntu:xenial

# Try to copy file now to issue error if it doesn't exist
# before spending all the time building
COPY passwd.txt /root/passwd.txt

RUN apt-get update

# Docker setup
RUN apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

RUN apt-key fingerprint 0EBFCD88

RUN add-apt-repository -y \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

RUN apt-get update

# Install SSHD
RUN apt-get install -y openssh-server docker-ce

# SSHD part
RUN mkdir /var/run/sshd

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22

# Copy again at end to make it easy to
# change password without rebuilding.
# Uncomment (or recomment) the next line to rebuild from this point
RUN true
COPY passwd.txt /root/passwd.txt

# Set root password from passwd.txt on host
RUN echo "root:$(cat /root/passwd.txt)" | chpasswd -e
RUN rm /root/passwd.txt

# Run SSHD
CMD ["/usr/sbin/sshd", "-D"]
