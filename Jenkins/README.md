
# Jenkins Master and slave set up

__Steps:__

1. Add credentials
2. Add node


### 1. Add credentials

1) Create jenkins user on master and slave
2) Add jenkins user to sudoers.
3) login as root on slave machine 

        root@jenkins-node:/var/lib# mkdir jenkins
        root@jenkins-node:/var/lib# chown jenkins jenkins
        root@jenkins-node:/var/lib# chgrp jenkins jenkins

4) /var/lib/jenkins is the jenkin user's home directory  on master. So jenkins user on slave should also have the same home directory.

        root@jenkins-node:/var/lib# usermod -d /var/lib/jenkins jenkins

5) generate ssh keys for jenkins on master and slave.(/var/lib/jenkins/.ssh)

6) Copy the public key from master to authorized_keys on slave and viceversa.


Dashboard->Manage Jenkins->Credentials->System->Global credentials (unrestricted)


Private key of the jenkins-master machine is added.

We can test the connection by creating a freestyle job.



