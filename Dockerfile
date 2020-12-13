FROM jenkins/jenkinsfile-runner:1.0-beta-23
RUN mkdir -p /nonexistent && chown -R nobody /nonexistent && chmod a+rw -R /usr/share/jenkins /app
USER nobody
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN  cd /app/jenkins && jar -cvf jenkins.war *
RUN  java -jar /app/bin/jenkins-plugin-manager.jar --war /app/jenkins/jenkins.war --plugin-file /usr/share/jenkins/ref/plugins.txt 
RUN  rm /app/jenkins/jenkins.war
COPY jenkinsfile-runner-launcher.sh /app/bin/jenkinsfile-runner-launcher.sh
COPY extract-plugins.sh /app/bin/extract-plugins.sh
COPY cloud-kubernetes.yaml  /usr/share/jenkins/ref/casc/jenkins.yaml
RUN  /app/bin/extract-plugins.sh
CMD  /app/bin/jenkinsfile-runner-launcher.sh
ENTRYPOINT ["/app/bin/jenkinsfile-runner-launcher.sh"]
