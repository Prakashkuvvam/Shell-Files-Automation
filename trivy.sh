#!/bin/bash

set -e

echo "Updating package index..."
sudo apt-get update

echo "Installing required packages..."
sudo apt-get install -y wget gnupg lsb-release apt-transport-https

echo "Adding Trivy GPG key..."
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key \
    | gpg --dearmor \
    | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null

echo "Adding Trivy repository..."
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" \
    | sudo tee /etc/apt/sources.list.d/trivy.list

echo "Updating package index..."
sudo apt-get update

echo "Installing Trivy..."
sudo apt-get install -y trivy

echo "Verifying installation..."
trivy --version

echo "✅ Trivy installation completed successfully."
