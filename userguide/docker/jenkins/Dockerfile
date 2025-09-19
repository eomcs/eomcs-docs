FROM jenkins/jenkins:latest

USER root

COPY install_docker.sh /install_docker.sh
RUN chmod +x /install_docker.sh
RUN /install_docker.sh

RUN usermod -aG docker jenkins
RUN setfacl -Rm d:g:docker:rwx,g:docker:rwx /var/run/

USER jenkins
