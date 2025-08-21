#!/bin/bash
#
# This script installs Docker, k6, Git, and the latest Node.js on a
# Debian 13 (Trixie) system, such as an AWS EC2 instance.
#
# It should be run with sudo privileges or by a user with sudo access.
# To run:
#   chmod +x install_tools.sh
#   ./install_tools.sh

# Exit immediately if a command exits with a non-zero status.
set -e

# --- 1. System Update and Prerequisite Installation ---
echo ">>> Step 1: Updating package lists and installing prerequisites..."
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release git
echo "✅ Prerequisites installed."
echo ""

# --- 2. Install Docker ---
echo ">>> Step 2: Setting up Docker repository and installing Docker Engine..."
# Add Docker's official GPG key
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the Docker repository to Apt sources
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo apt-get update

# Install the latest version of Docker Engine and plugins
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add the current user to the 'docker' group to run docker commands without sudo.
# NOTE: This change requires a new login session (log out and log back in) to take effect.
sudo usermod -aG docker $USER
echo "✅ Docker installed successfully."
echo ""

# --- 3. Install k6 ---
# sudo gpg -k
sudo gpg --no-default-keyring --keyring /usr/share/keyrings/k6-archive-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C5AD17C747E3415A3642D57D77C6C491D6AC1D69
echo "deb [signed-by=/usr/share/keyrings/k6-archive-keyring.gpg] https://dl.k6.io/deb stable main" | sudo tee /etc/apt/sources.list.d/k6.list
sudo apt-get update
sudo apt-get install -y k6
echo "✅ k6 installed successfully."
echo ""

# --- 4. Install Latest Node.js ---
echo ">>> Step 4: Setting up NodeSource repository for the latest Node.js..."
# The setup_current.x script from NodeSource configures the repository for the latest stable release line.
curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -

# Install Node.js and npm
sudo apt-get install -y nodejs
echo "✅ Node.js installed successfully."
echo ""

# --- 5. Final Verification ---
echo "----------------------------------------------------"
echo ">>> Verification: Checking the versions of all installed tools..."
echo "----------------------------------------------------"

echo -n "Git version:       "
git --version

echo -n "Docker version:    "
docker --version

echo "k6 version:"
k6 version

echo -n "Node.js version:   "
node -v

echo -n "npm version:       "
npm -v

echo "----------------------------------------------------"
echo "🎉 All tools have been installed successfully."
echo "IMPORTANT: To use Docker without 'sudo', you must log out and log back in."
echo "----------------------------------------------------"
