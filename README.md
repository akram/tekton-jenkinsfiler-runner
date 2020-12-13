# tekton-jenkinsfiler-runner

jenkinsfile-runner image usable for tekton.

## Build
```
docker build . -t quay.io/akram/tekton-jenkinsfile-runner
```


## Usage
```
docker run quay.io/akram/tekton-jenkinsfile-runner <JENKINSFILE_URL>
# eg: "https://raw.githubusercontent.com/akram/jenkinsfile-runner-openshift/f2f/Jenkinsfile"
```
