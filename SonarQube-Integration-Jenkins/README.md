# SonarQube Integration with Jenkins

1. Create an account at https://sonarcloud.io

Login using GitHub account.

2. Generate an authentication token on SonarQube

My account -> Security -> Generate token.

3. Create credentials for token in Jenkins.

4. Download SonarQube scanner plugin in Jenkins.

Manage Jenkins -> Plugins -> Available Plugins -> SonarQube scanner plugin.


5. Configure SonarQube server.

Manage Jenkins -> System -> SonarQube installation - > Add SonarQube.

6. Add SonarQube scanner to Jenkins.

Manage Jenkins -> Tools -> Sonar scanner installations.
