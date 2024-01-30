
# Docker-Jenkins-Jfrog artifactory Integration

#### 1. Create Dockerfile.

        FROM openjdk:8
        ADD target/*.jar ttrend.jar
        ENTRYPOINT ["java", "-jar", "ttrend.jar]

#### 2. Create Docker repository in Artifactory.

Repositories -> Create repository -> Select docker -> Repository prefix -> create.

<img width="795" alt="dockerrepo" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/279ce0a9-bc4d-4108-ac6f-aecaf1f845a4">


#### 3. Install docker pipeline plugin

Manage Jenkins -> Plugins -> Available Plugins -> docker pipeline -> Install

#### 4. Add docker build and publish to artifactory stage in the jenkins file.

define Image name and version along with registry outside the pipeline.

    def imageName = 'devopsdecember2023.jfrog.io/mydevops2023-docker-local/ttrend'
    def version = '2.1.2'


        stage("Docker Build"){
          steps{
            script{
              echo "<---------------- Docker build started --------------->"
              app = docker.build(imageName+":"+version)
              echo "<----------------Docker build completed -------------->"
            }
      }
        } 
        stage("Publish docker to artifactory"){
          steps{
            script{
              echo "<----------------Docker publish started ------------------>"
              docker.withRegistry(registry,'artifactory_cred'){
              app.push()
              }
              echo "<----------------------- Docker publish completed ----------->"
            }
         }        
        }

<img width="939" alt="dockerimagepublished" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/fb3fc10f-c8d6-4a24-9ff0-468b3ab258e3">

#### 5. Test docker image by creating container from the image.

<img width="812" alt="dockertest1" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/ea630076-3c54-4fb1-9372-5760b77a95a5">

<img width="644" alt="dockertest2" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/afddb41b-5681-4130-9369-b0ea9a47017d">


