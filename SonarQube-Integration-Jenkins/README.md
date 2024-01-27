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

<img width="903" alt="add-sonar-scanner" src="https://github.com/anuja2015/DevOps-Full-Project/assets/16287330/86a9d65d-1c21-4032-b711-1248f6b373bc">

