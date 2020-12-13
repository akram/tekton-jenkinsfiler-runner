#!/bin/sh
JENKINSFILE_URL=$1

export JAVA_OPTS="${JAVA_OPTS:+$JAVA_OPTS}"
export JAVA_OPTS="${JAVA_OPTS} -Dhudson.TcpSlaveAgentListener.hostName=$(hostname -i)"
export JAVA_OPTS="${JAVA_OPTS} -Djenkins.model.Jenkins.slaveAgentPort=50000"
export JAVA_OPTS="${JAVA_OPTS} -Djenkins.model.Jenkins.slaveAgentPortEnforce=true"
export JAVA_OPTS="${JAVA_OPTS} -Dhudson.slaves.NodeProvisioner.initialDelay=1" # How long to wait after startup before starting to provision nodes from clouds
export JAVA_OPTS="${JAVA_OPTS} -Dhudson.slaves.ConnectionActivityMonitor.timeToPing=30000" # wait after startup to start checking agent connections, in milliseconds.

curl -ks -o /tmp/Jenkinsfile $JENKINSFILE_URL 2> /dev/null 
if [ $? -ne 0 ]; then
  echo "Error while trying to download Jenkinsfile from $JENKINSFILE_URL"
  exit 1
else
  echo "Jenkinsfile downloaded"
fi

mkdir -p /tmp/workspace

/app/bin/jenkinsfile-runner-launcher run -p /usr/share/jenkins/ref/plugins/ -f /tmp/Jenkinsfile  -w /tmp/workspace
