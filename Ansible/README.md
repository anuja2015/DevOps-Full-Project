

# Ansible to configure Jenkins and Maven

## Set up Ansible server

        sudo apt update
        sudo apt install -y software-properties-common
        sudo add-apt-repository --yes --update ppa:ansible/ansible
        sudo apt install -y ansible

## Add Jenkins server and build node as managed nodes in ansible inventory

/opt would be the working directory for ansible

1. Add hosts file for inventory like below.

        root@Ansible-server:/opt# cat hosts
        [jenkins-master]
        172.203.8.76

        [jenkins-master:vars]
        ansible_user=azureuser

        [jenkins-node]
        20.110.183.229

        [jenkins-node:vars]
        ansible_user=azureuser


2. Generate ssh keys on ansible(as root), jenkins master and node

         ssh-keygen

3. Copy public key of ansible server(as root) and save it in authorized_keys on jenkins master and node.

4. Copy the public key on jenkins master and node and save it in authorized_keys on ansible(as root)

5. Test the connectivity

        root@Ansible-server:/opt# ansible all -i hosts -m ping
        [WARNING]: Invalid characters were found in group names but not replaced, use -vvvv to see details
        172.203.8.76 | SUCCESS => {
            "ansible_facts": {
                "discovered_interpreter_python": "/usr/bin/python3"
            },
            "changed": false,
            "ping": "pong"
        }
        20.110.183.229 | SUCCESS => {
            "ansible_facts": {
                "discovered_interpreter_python": "/usr/bin/python3"
            },
            "changed": false,
            "ping": "pong"
        }

__Note__: When connecting first time, the following will be asked. We will have to give yes.

    The authenticity of host '172.203.8.76 (172.203.8.76)' can't be established.
    ED25519 key fingerprint is SHA256:PRS40Zag+nzS0xGedjJZdKiRxbaYOEv2ME1gQ1w7STc.
    This key is not known by any other names
    Are you sure you want to continue connecting (yes/no/[fingerprint])? 


## Set up Jenkins using Ansible.

Manual Jenkins installation steps

1. Install Java

        sudo apt install openjdk-11-jdk
2. Add Jenkins repo key to system

        sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

3. Add jenkins repository  to the system.

        echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
4. Install dependencies        

         sudo apt-get update

5. Install jenkins

        sudo apt-get install jenkins

#### These steps are written in ansible yaml and executed.

## Set up Maven using Ansible.

Steps:

1. Update cache
2. Install Java
3. Download Maven packages
4. Untar maven package.

#### These steps are done using ansible yaml files on ansible server.

    root@jenkins-node:/opt# /opt/apache-maven-3.9.6/bin/mvn --version
    Apache Maven 3.9.6 (bc0240f3c744dd6b6ec2920b3cd08dcc295161ae)
    Maven home: /opt/apache-maven-3.9.6
    Java version: 11.0.21, vendor: Ubuntu, runtime: /usr/lib/jvm/java-11-openjdk-amd64
    Default locale: en, platform encoding: UTF-8
    OS name: "linux", version: "6.2.0-1016-azure", arch: "amd64", family: "unix"






