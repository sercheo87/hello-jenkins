```
docker container exec -u 0 -it jenkins-full bash

wget http://updates.jenkins-ci.org/download/war/2.250/jenkins.war
mv ./jenkins.war /usr/share/jenkins
chown jenkins:jenkins /usr/share/jenkins/jenkins.war

exit
docker container restart jenkins-full
```

```
docker container exec -u 0 -it jenkins-full bash

```

https://medium.com/@schogini/running-docker-inside-and-outside-of-a-jenkins-container-along-with-docker-compose-a-tiny-c908c21557aa

```
mkdir /etc/docker/
touch /etc/docker/daemon.json

echo '{
        "registry-mirrors": [],
        "insecure-registries": [],
        "debug": true,
        "experimental": true
      }' >> /etc/docker/daemon.json
```

apt update  -qq && apt install docker-ce=17.12.1~ce-0~debian -y

```
from jenkinsci/jenkins:lts
 
USER root
RUN apt-get update -qq \
    && apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common 
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
RUN apt-get update  -qq \
    && apt-get install docker-ce=17.12.1~ce-0~debian -y
RUN usermod -aG docker jenkins
```

DOCKER_HOST="192.168.100.101:2375" docker-compose up -d
