# docker build -t jenkins .
# docker tag jenkins <DOCKER_REGISTRY>/jenkins:latest
# docker push <DOCKER_REGISTRY>/jenkins:latest 
# docker login -u _json_key -p "$(cat config.json)" https://<DOCKER_REGISTRY>

#sudo chown 1000
#docker run --name jenkins -d -p 8089:8080 -p 50000:50000 -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/jenkins:/var/jenkins_home -v /usr/bin/docker:/usr/bin/docker -v /opt/service-account:/opt/service-account <DOCKER_REGISTRY>/jenkins

FROM jenkins/jenkins
COPY plugins.txt /usr/share/jenkins/plugins.txt
COPY /groovy/executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

USER root
RUN apt-get update \
      && apt-get install -y sudo telnet \
      && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y libltdl7 && rm -rf /var/lib/apt/lists/*
# USER jenkins