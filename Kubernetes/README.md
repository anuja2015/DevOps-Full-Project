
# Kubernetes


As jenkins user
kubectl

azure-cli
az aks cli
az aks get-credentials --resource-group devops-RG --name mydevops-cluster

namespace.yaml
deployment.yaml

imagepulloff error

create user in jfrog with password

Jfrog@123

root@jenkins-node:/opt/kubernetes# docker login https://devopsdecember2023.jfrog.io
Username: dockercred
Password:
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
root@jenkins-node:/opt/kubernetes#


root@jenkins-node:/opt/kubernetes# cat /root/.docker/config.json | base64 -w0
ewoJImF1dGhzIjogewoJCSJkZXZvcHNkZWNlbWJlcjIwMjMuamZyb2cuaW8iOiB7CgkJCSJhdXRoIjogIlpHOWphMlZ5WTNKbFpEcEtabkp2WjBBeE1qTT0iCgkJfQoJfQp9root@jenkins-node:/opt/kubernetes#

use this value in secret.yaml

kubectl apply -f secret.yaml

delete existing pods

kubectl delete pod/mydevops-rtp-64d9945ff9-jklf8 -n mydevops2023



root@jenkins-node:/opt/kubernetes# kubectl get all -n mydevops2023
NAME                                READY   STATUS    RESTARTS   AGE
pod/mydevops-rtp-64d9945ff9-tgxzf   1/1     Running   0          54s
pod/mydevops-rtp-64d9945ff9-wm8ql   1/1     Running   0          32s

NAME                           READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/mydevops-rtp   2/2     2            2           35m

NAME                                      DESIRED   CURRENT   READY   AGE
replicaset.apps/mydevops-rtp-64d9945ff9   2         2         2       35m
root@jenkins-node:/opt/kubernetes#


create service of type loadbalancer


