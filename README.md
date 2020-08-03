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


 echo "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-`uname -s`-`uname -m`"
                curl -L https://github.com/docker/compose/releases/download/1.26.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
                curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
                chmod +x /usr/local/bin/docker-compose
                ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
                
docker-compose -f docker-compose.yml -H $DOCKER_HOST --tls --tlsverify --tlscacert '/certs/client/ca.pem' --tlscert '/certs/client/cert.pem' --tlskey '/certs/client/key.pem' build


docker.withServer('tcp://jenkins-docker:2376', registryCredential) {
    docker.image('docker/compose').withRun('-e DOCKER_HOST=unix://jenkins-docker:2376 -e DOCKER_TLS_VERIFY=0 -e DOCKER_CERT_PATH=/certs/client -v /certs/client:/certs/client:ro') {
        sh 'docker-compose up -d'
    }
}

curl -L --fail https://github.com/docker/compose/releases/download/1.21.2/run.sh -o /usr/local/bin/docker-compose
curl -L --fail https://github.com/docker/compose/releases/download/1.26.2/run.sh -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose


apk add ca-certificates wget && \
wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
GLIBC_VERSION='2.27-r0' && \
wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk && apk add glibc-${GLIBC_VERSION}.apk && \
wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk && apk add glibc-bin-${GLIBC_VERSION}.apk


docker run --rm \
    --name test-compose \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /var/jenkins_home/workspace/hello-jenkins:/app-test \
    -w /app-test \
    docker/compose \
    sh -c 'docker-compose up'
    
docker run --rm --name test-compose -v /postman-test:/app-test nexussrv.com:14442/node:12 sh -c 'ls -la /app-test'
docker run --rm -t -i -v $(pwd):/app-test  nexussrv.com:14442/node:12 /bin/bash    
