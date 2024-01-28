
# JFrog Artifactory Integration

### What is JFrog Artifactory?

- Artifactory is a universal DevOps solution for hosting, managing, and distributing binaries and artifacts. 
- Any type of software in binary form – such as application installers, container images, libraries, configuration files, etc. – can be curated, secured, stored, and delivered using Artifactory.

### Steps for Integration

1. Create an Artifactory account
2. Generate access token with username
3. Add username and accesstoken in Jenkins credentials.
4. Install Artifactory plugin.
5. Update Jenkinsfile with jar publish stage.
6. Create a dockerfile
7. Create and publish docker image to artifactory.


#### 1. Create Artifactory account.

Go to https://jfrog.com/ and in Products tab select JFrog Artifactory.

I am using Cloud trial version of 14 days. 

Create an account using GitHub credentials (SSO).

<img width="855" alt="Jfrog1" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/98ef12bd-a8cd-477f-98b9-dbc84c2c5ff4">

<img width="908" alt="Jfrog2" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/8602781b-43d7-4261-ae1d-9bbe0d2bfec8">

<img width="960" alt="Jfrog3" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/fab6aa0a-82e6-4cf5-993d-920ab62d3c0c">

This would be the url for my project and I will be logging in using github credentials.

https://devopsdecember2023.jfrog.io/ui/login?auth_method=github

### 2. Create Maven repository

<img width="522" alt="Jfrogmaven" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/ae642a2f-6738-4c95-83ea-525a43db62e9">

<img width="937" alt="Jfrogmaven1" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/115d9f0f-c45a-43ac-aa45-a5ff09b27b1b">

Maven Repository: mydevops2023-libs-snapshot 

https:///artifactory/api/maven/mydevops2023-libs-snapshot



