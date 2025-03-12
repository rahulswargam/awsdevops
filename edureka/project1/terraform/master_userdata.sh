#!/bin/bash

set -e

# Update and upgrade system packages
sudo apt update -y && sudo apt upgrade -y

# Install common dependencies
sudo apt install -y jq curl unzip zip wget gnupg software-properties-common

# Install Python & Pip
sudo apt install -y python3 python3-pip
python3 --version
pip3 --version

# Install OpenSSH Server
sudo apt install -y openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh
sudo ufw allow ssh

# Install Ansible
sudo apt install -y ansible
ansible --version

# Install Java (OpenJDK 17)
sudo apt install -y openjdk-17-jdk
java -version

# Install Git
sudo apt install -y git
git --version

# Install Maven
sudo apt install -y maven
mvn -version

# Install Docker
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER
sudo systemctl enable docker
sudo systemctl start docker
docker --version

# Install Kubernetes (kubeadm, kubectl, kubelet)
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update -y
sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
kubectl version --client
kubeadm version

# Install Terraform
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update -y
sudo apt install -y terraform
terraform --version

# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf awscliv2.zip aws
aws --version

# Install Jenkins (LTS Version 17)
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc >/dev/null
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list
sudo apt update -y
sudo apt install -y jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins
sleep 10  # Wait for Jenkins to start
echo "Jenkins is running on http://localhost:8080"

# Ensure Jenkins is fully started
while ! curl -s http://localhost:8080/login; do
  echo "Waiting for Jenkins to start..."
  sleep 10
done

# Move the admin user Groovy script
sudo mkdir -p /var/lib/jenkins/init.groovy.d/
sudo mv /home/ubuntu/adminUser.groovy /var/lib/jenkins/init.groovy.d/adminUser.groovy
sudo chown jenkins:jenkins /var/lib/jenkins/init.groovy.d/adminUser.groovy

# Skip initial setup
echo "JENKINS_OPTS=\"--argumentsRealm.passwd.admin=$JENKINS_PASS --argumentsRealm.roles.admin=admin --setupWizard=false\"" | sudo tee -a /etc/default/jenkins

# Restart Jenkins
sudo systemctl restart jenkins
sleep 60  # Allow Jenkins to fully restart

# Install plugins
echo "Installing Jenkins plugins from file..."
while read plugin; do
  java -jar /var/lib/jenkins/jenkins-cli.jar -s http://localhost:8080 install-plugin $plugin
done < /home/ubuntu/jenkins_plugins.txt

# Restart Jenkins again to apply plugin installation
sudo systemctl restart jenkins

# Clean up repositories and unused packages
sudo apt autoremove -y
sudo apt clean
sudo rm -rf /var/lib/apt/lists/*

echo "Jenkins setup complete! Admin user created and plugins installed."
echo "All installations completed successfully!"