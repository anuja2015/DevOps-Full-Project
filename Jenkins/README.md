
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

<img width="644" alt="Add_credentials_1" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/46a49b9f-cae7-452c-9c9e-58dd39489279">

<img width="895" alt="Add_credentials_2" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/b93ad599-e372-4045-b33a-923db3fa6ad4">

Private key of the jenkins-master machine is added.

### 2. Add node.
<img width="566" alt="Add_node_1" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/5adf47dc-304e-4d42-9011-738e9d697bc2">
<img width="799" alt="Add_node_2" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/2a76e604-5e35-41bf-b2d9-a61661c5c76e">
<img width="815" alt="Add_node_3" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/84ed6050-2a21-4330-88e2-f3e2f85d0beb">
<img width="823" alt="Add_node_4" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/d839b655-9578-4e3f-b0f7-5d8d611d773a">

We can test the connection by creating a freestyle job.

<img width="639" alt="test_job_1" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/aa874dcc-fe9e-4a47-b806-d6ac536deab7">
<img width="644" alt="test_job_2" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/8e5a8e32-5638-4987-88c2-42d67ea041fa">





