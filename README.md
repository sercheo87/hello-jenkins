```
docker container exec -u 0 -it jenkins-full bash

wget http://updates.jenkins-ci.org/download/war/2.250/jenkins.war
mv ./jenkins.war /usr/share/jenkins
chown jenkins:jenkins /usr/share/jenkins/jenkins.war

exit
docker container restart jenkins-full
```
