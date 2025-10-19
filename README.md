# Northwind Bikes ARM Deployment

This repository contains an **ARM template** and deployment script to provision a Linux VM with NGINX, a public IP, and a sample web page for Northwind Bikes.

---

## Architecture

- **Resource Group:** Pre-existing (e.g., `Student-RG-1879876`)  
- **Virtual Network (VNet):** `NW-VNet`  
  - Subnet: `WebSubnet`  
  - Associated Network Security Group (NSG): `NW-NSG`  
- **Network Security Group (NSG):**  
  - Inbound rules for SSH (port 22) restricted to your IP  
  - Inbound rules for HTTP (port 80) open  
- **Public IP:** `NW-PublicIP`  
- **Network Interface:** `NW-NIC` attached to VM  
- **VM:** `northwindvm`  
  - Ubuntu 22.04 LTS  
  - SSH login enabled via public key  
  - NGINX installed via Custom Script Extension  
  - Sample HTML page deployed to `/var/www/html/index.html`

---

## Prerequisites

- Azure CLI installed --> A script for this has been added into the repository, once cloned please run the script after providing it execute permissions. 
- `jq` installed for parsing JSON outputs  --> One can install jq using "sudo apt install jq".
- SSH key pair ready (`~/.ssh/id_rsa.pub`)  
- Access to your IP (for SSH in NSG)

---

## Deployment Steps

1. Clone the repository:

```bash
git clone <repo-url>
cd <repo-folder>
```

2. Make the deployment script executable:
```bash
chmod u+x deploy.sh
```

3. Run the deployment script:
```bash
./deploy.sh
```

## Validation Process
- The script will validate the ARM template
- If the validation passes it will proceed to deploy all resources
- Generates an output listing the; Public IP, Website URL, and a SSH hint
- The script also performs a curl test on the website

## Notes
- The configured NSG only allows SSH connecitivty via my public IP, restricts/drops all other SSH traffic.
- Port 80 HTTP traffic is allowed from the "internet"/anywhere.
- Nginx is installed via custom script extension on the VM.


