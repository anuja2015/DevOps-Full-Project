
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
user -> jenkins

<img width="644" alt="Add_credentials_1" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/46a49b9f-cae7-452c-9c9e-58dd39489279">

<img width="895" alt="Add_credentials_2" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/b93ad599-e372-4045-b33a-923db3fa6ad4">

Private key of the jenkins user on jenkins-master machine is added.

### 2. Add node.

root directory -> /var/lib/jenkins

<img width="566" alt="Add_node_1" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/5adf47dc-304e-4d42-9011-738e9d697bc2">
<img width="799" alt="Add_node_2" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/2a76e604-5e35-41bf-b2d9-a61661c5c76e">
<img width="815" alt="Add_node_3" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/84ed6050-2a21-4330-88e2-f3e2f85d0beb">
<img width="823" alt="Add_node_4" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/d839b655-9578-4e3f-b0f7-5d8d611d773a">

We can test the connection by creating a freestyle job.

<img width="639" alt="test_job_1" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/aa874dcc-fe9e-4a47-b806-d6ac536deab7">
<img width="644" alt="test_job_2" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/8e5a8e32-5638-4987-88c2-42d67ea041fa">


# Creating pipeline code.

The syntax for the pipeline as code:

        pipeline{
            agent {
                node{
                    label 'xxx'
                }
            }
            stages{
                stage("name_of_the_stage"){
                    steps{

                    }
                }
            }
        }

The pipeline code must be versioned by commiting to the source code repository.

## Jenkinsfile from SCM and adding github credentials.

<img width="639" alt="Add_credentials_11" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/f9debf74-323f-4e16-833b-d4583cd1d79b">

<img width="623" alt="Add_credentials_12" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/83701d46-584f-4f02-81c4-7529db585552">

<img width="903" alt="Add_credentials_13" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/0545bf7b-7a66-44ae-977a-bd638ff4a83c">

## Multibranch pipeline

- Multibranch pipeline enables us to implement different jenkinsfiles for different branches of the same project.
- Jenkins automatically discovers, manages and creates pipelines for the branches that have jenkinsfile.
- It automatically creates individual Pipelines for each branch, allowing parallel testing and deployment

To demonstrate multibranch pipeline, I created 2 branches in the project code repository, dev and test. dev branch has jenkinsfile and test branch doesnt have.

master and dev pipelines are created, test pipeline not created since there was no jenkinsfile found.

<img width="662" alt="multibranch" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/aa37f3e8-eb04-4451-b33f-b0e3f9b7cfa4">

<img width="646" alt="multibranch-2" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/85a9be42-12d9-4ebd-99c1-a387ee98de64">

## Enable Github webhook

1. Install multibranch scan webhook trigger plugin.

Dashboard -> Manage Jenkins -> Plugins -> Available Plugins -> Multibranch Scan Webhook trigger.

2. Configure the multibranch pipeline job.

Multibranch pipeline job -> Configure -> Scan Multibranch pipeline triggers -> Scan by webhook -> trigger token

JENKINS_URL/multibranch-webhook-trigger/invoke?token=[Trigger token]  ----> This url has to  be customised to create Payload URL.

<img width="904" alt="multibranch-scan-trigger" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/d955bd2d-9f63-4c2d-8fb8-7d65aff517cc">


3. Add webhook to the GitHub repository.

GitHub -> devops-project-code -> Settings -> Webhooks-> Add webhook
Payload URL -> http://172.177.85.218:8080/multibranch-webhook-trigger/invoke?token=my-token

<img width="778" alt="webhook" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/c09add5c-7776-4080-93ff-336a0d43d986">

<img width="896" alt="webhook1" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/e1196f35-3c3d-41ec-92f9-3876d7b43b73">









