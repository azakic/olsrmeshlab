############################################################
# Dockerfile to build MeshLab container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu

# File Author / Maintainer
MAINTAINER AZ

#ADD run  /usr/local/sbin/run
#RUN chmod 755 /usr/local/sbin/run
VOLUME /root/meshlab

# Update the repository sources list
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install python

# Install wget iperf
RUN apt-get install -y wget iperf supervisor nano olsrd olsrd-plugins telnet openssh-server
RUN cd /usr/local/bin && wget 172.17.42.1:9999/squirrel-worker && chmod +x squirrel-worker
COPY ./olsrdmeshlab.conf /
RUN echo 'root:olsrmeshlab' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
