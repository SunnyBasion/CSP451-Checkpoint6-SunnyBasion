# Remove any wrong repo
sudo rm /etc/apt/sources.list.d/azure-cli.list

# Install prerequisites
sudo apt update
sudo apt install -y ca-certificates curl apt-transport-https gnupg lsb-release

# Add Microsoft GPG key
curl -sL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/microsoft.gpg

# Add Azure CLI repo using Ubuntu codename 'jammy'
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ jammy main" | sudo tee /etc/apt/sources.list.d/azure-cli.list

# Update and install
sudo apt update
sudo apt install -y azure-cli

# Verify
az version

