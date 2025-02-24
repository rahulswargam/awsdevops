#!/bin/bash

# UPDATE THE SYSTEM:
sudo yum update -y

# INSTALL WGET
sudo yum install wget -y

# INSTALL JAVA (Required for Jenkins & Maven):
sudo yum install fontconfig java-17-openjdk

# INSTALL JENKINS:
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade
sudo yum install jenkins -y
sudo systemctl daemon-reload

# INSTALL GIT:
sudo yum install git -y

# INSTALL MAVEN:
sudo yum install maven -y

# START AND ENABLE JENKINS SERVICE:
sudo systemctl daemon-reload
sudo systemctl start jenkins
sudo systemctl enable jenkins
echo "Jenkins Installation Completed"