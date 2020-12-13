FROM jenkins/jenkinsfile-runner:1.0-beta-23
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN cd /app/jenkins && jar -cvf jenkins.war *
RUN java -jar /app/bin/jenkins-plugin-manager.jar --war /app/jenkins/jenkins.war --plugin-file /usr/share/jenkins/ref/plugins.txt 
RUN rm /app/jenkins/jenkins.war
COPY jenkinsfile-runner-launcher.sh /app/bin/jenkinsfile-runner-launcher.sh
COPY cloud-kubernetes.yaml  /usr/share/jenkins/ref/casc/jenkins.yaml
CMD /app/bin/jenkinsfile-runner-launcher.sh
ENTRYPOINT ["/app/bin/jenkinsfile-runner-launcher.sh"]
