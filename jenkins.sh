#!/bin/bash
set -e

echo "Updating package index..."
sudo apt update

echo "Installing dependencies..."
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    wget \
    git \
    unzip \
    maven

echo "Installing Java 21..."
sudo apt install -y openjdk-21-jdk

echo "Creating keyring directory..."
sudo mkdir -p /etc/apt/keyrings

echo "Downloading Jenkins repository key..."
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key \
| sudo tee /etc/apt/keyrings/jenkins-keyring.asc >/dev/null

echo "Adding Jenkins repository..."
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
| sudo tee /etc/apt/sources.list.d/jenkins.list >/dev/null

echo "Updating package index..."
sudo apt update

echo "Installing Jenkins..."
sudo apt install -y jenkins

echo "Enabling and starting Jenkins..."
sudo systemctl enable jenkins
sudo systemctl restart jenkins

echo
echo "Jenkins status:"
sudo systemctl --no-pager status jenkins

echo
echo "Initial Admin Password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

echo
echo "Open Jenkins in your browser:"
hostname -I | awk '{print "http://" $1 ":8080"}'
