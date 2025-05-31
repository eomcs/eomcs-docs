FROM ubuntu:focal

USER root

RUN mkdir /root/.ssh
COPY docker-jenkins-key.pub /root/.ssh/authorized_keys

COPY install-docker.sh ./install-docker.sh
RUN chmod +x /install-docker.sh
RUN /install-docker.sh

RUN setfacl -Rm d:g:docker:rwx,g:docker:rwx /var/run/

RUN service ssh start
CMD ["/usr/sbin/sshd", "-D"]