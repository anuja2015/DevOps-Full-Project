# SonarQube Integration with Jenkins

1. Create an account at https://sonarcloud.io

Login using GitHub account.

2. Generate an authentication token on SonarQube

My account -> Security -> Generate token.

<img width="628" alt="sonarcloudtoken" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/2f3aa9db-db4f-42ed-9d17-c53469d20ebf">


3. Create credentials for token in Jenkins.

   <img width="854" alt="sonarcred" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/eb8d499b-1d8e-44ee-bee7-57d88537c670">

4. Download SonarQube scanner plugin in Jenkins.

Manage Jenkins -> Plugins -> Available Plugins -> SonarQube scanner plugin.

5. Configure SonarQube server.

Manage Jenkins -> System -> SonarQube installation - > Add SonarQube.

<img width="869" alt="add-sonarqube-server" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/35bfc563-9e56-4803-9486-9ea919e22edc">


6. Add SonarQube scanner to Jenkins.

Manage Jenkins -> Tools -> Sonar scanner installations.

<img width="903" alt="add-sonar-scanner" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/31bf89cd-d691-46e2-a671-ceeb4f92ecf2">


7. Create SonarQube properties file.

   1. Create organization.
   My account -> Organizations -> Create -> create an organization manually.

<img width="736" alt="create-org" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/31928b52-823f-43c9-98be-12cf7727c500">

<img width="857" alt="create-org1" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/635ea303-d864-43a9-9d8b-0b510f543674">

   2. Create new projct to analyse
   My account -> Organizations -> mydevops2023 -> Analyze a new project.

<img width="574" alt="create-proj" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/22ac70b3-d8ac-4857-82c6-66d161f009e1">

<img width="554" alt="create-proj1" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/31d04b13-66e8-4531-9133-a6cdcb57d375">

<img width="907" alt="create-proj2" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/6a1402ec-9e27-4d7b-b11f-ac1631d84d17">

Now create sonar-project.properties in the root folder of the source code. 

    sonar.verbose=true
    sonar.organization=mydevops2023
    sonar.projectKey=mydevops23_tweettrend
    sonar.projectName=tweettrend
    sonar.language=java
    sonar.sourceEncoding=UTF-8
    sonar.sources=.
    sonar.java.binaries=target/classes
    sonar.coverage.jacoco.xmlReportPaths=target/site/jacoco/jacoco.xml 
    
8. Add SonarQube stage in the Jenkinsfile.

    stage('SonarQube analysis') {
          steps{
                withSonarQubeEnv('my-sonarqube-server') { // If you have configured more than one global server connection, you can specify its name
                sh "${scannerHome}/bin/sonar-scanner"
    }
          }
        }

Also add environment variable
     scannerHome = tool 'my-sonar-scanner'



