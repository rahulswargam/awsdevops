# Use the official Jenkins LTS image
FROM jenkins/jenkins:lts

# Switch to root user to install packages
USER root

# Install required packages
RUN apt-get update && \
    apt-get install -y curl unzip zip wget gnupg software-properties-common && \
    wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com bookworm main" | tee /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && \
    apt-get install -y terraform && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    apt-get clean

# Install Jenkins Plugins Automatically
RUN jenkins-plugin-cli --plugins \
    git \
    build-pipeline-plugin \
    aws-credentials \
    pipeline-stage-view \
    credentials-binding \
    terraform \
    ssh-slaves \
    workflow-aggregator \
    aws-java-sdk-ec2 \
    cloudbees-folder

# Expose default Jenkins ports
EXPOSE 8080 50000

# Set Jenkins environment variables
ENV JENKINS_HOME=/var/jenkins_home

# # Start Jenkins
# CMD ["jenkins.sh"]