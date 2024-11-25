#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Banner
echo -e "${BLUE}"
echo "================================================================"
echo "███████╗ ██╗      █████╗  ██████╗██╗███████╗██████╗ "
echo "██╔════╝ ██║     ██╔══██╗██╔════╝██║██╔════╝██╔══██╗"
echo "██║  ███╗██║     ███████║██║     ██║█████╗  ██████╔╝"
echo "██║   ██║██║     ██╔══██║██║     ██║██╔══╝  ██╔══██╗"
echo "╚██████╔╝███████╗██║  ██║╚██████╗██║███████╗██║  ██║"
echo " ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝╚══════╝╚═╝  ╚═╝"
echo "================================================================"
echo -e "${NC}"
echo -e "${GREEN}Auto Installation Script for Glacier Verifier Node${NC}"
echo -e "${YELLOW}Author: https://github.com/Galkurta${NC}"
echo "================================================================"

# Function to check if command executed successfully
check_status() {
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}[+] Success${NC}"
    else
        echo -e "${RED}[-] Failed${NC}"
        exit 1
    fi
}

# Function to prompt for private key
get_private_key() {
    read -p "Enter your EVM Private Key: " PRIVATE_KEY
    if [ -z "$PRIVATE_KEY" ]; then
        echo -e "${RED}Error: Private key cannot be empty${NC}"
        exit 1
    fi
}

# Function to prompt for custom port
get_custom_port() {
    read -p "Enter custom port (default: 10801): " CUSTOM_PORT
    CUSTOM_PORT=${CUSTOM_PORT:-10801}
}

# Main installation process
echo -e "\n${YELLOW}[1/4] Installing Prerequisites...${NC}"
sudo ufw allow 10801/tcp
check_status

echo -e "\n${YELLOW}Updating system packages...${NC}"
sudo apt update && sudo apt upgrade -y
check_status

echo -e "\n${YELLOW}Installing required packages...${NC}"
sudo apt install curl tar wget aria2 clang pkg-config libssl-dev jq build-essential -y
check_status

echo -e "\n${YELLOW}[2/4] Installing Docker...${NC}"
if command -v docker &> /dev/null; then
    echo -e "${GREEN}Docker already installed${NC}"
else
    sudo apt install docker.io -y
    sudo systemctl start docker
    sudo systemctl enable docker
    check_status
fi

echo -e "\n${YELLOW}Installing Docker Compose...${NC}"
sudo curl -L "https://github.com/docker/compose/releases/download/v2.30.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
check_status

echo -e "\n${YELLOW}Checking Docker version...${NC}"
docker --version
check_status

echo -e "\n${YELLOW}[3/4] Setting up Glacier Node...${NC}"
mkdir -p glacier && cd glacier
git clone https://github.com/Glacier-Labs/node-bootstrap
cd node-bootstrap
check_status

# Get user input
get_private_key
get_custom_port

# Create config.yaml
echo -e "\n${YELLOW}Creating config.yaml...${NC}"
cat > config.yaml << EOF
Http:
  Listen: "127.0.0.1:${CUSTOM_PORT}"
Network: "testnet"
RemoteBootstrap: "https://glacier-labs.github.io/node-bootstrap/"
Keystore:
  PrivateKey: "${PRIVATE_KEY}"
TEE:
  IpfsURL: "https://greenfield.onebitdev.com/ipfs/"
EOF
check_status

# Create testnet.yaml
echo -e "\n${YELLOW}Creating testnet.yaml...${NC}"
cat > testnet.yaml << EOF
Network: "testnet"
Bootstrap:
  Dcap:
    ChainID: 1398243
    ChainURL: "https://automata-testnet.alt.technology"
    ChainWSURL: "wss://1rpc.io/ata/testnet"
    ContractAddress: "0xefE368b17D137E86298eec8EbC5502fb56d27832"
  NodeCtrl:
    ChainID: 5611
    ChainURL: "https://opbnb-testnet.nodereal.io/v1/64a9df0874fb4a93b9d0a3849de012d3"
    ChainWSURL: "wss://opbnb-testnet.nodereal.io/ws/v1/64a9df0874fb4a93b9d0a3849de012d3"
    ContractAddress: "0x1F59347c5998a8Bb5E5f3ba8ec20c030CA5dd1D2"
  License:
    ChainID: 5611
    ChainURL: "https://opbnb-testnet-rpc.bnbchain.org"
    ChainWSURL: "wss://opbnb-testnet.nodereal.io/ws/v1/e9a36765eb8a40b9bd12e680a1fd2bc5"
    ContractAddress: "0xb813466384c915280f5b8ffa005fcc2cb5cf5b87"
  HeartbeatURL: "https://greenfield.onebitdev.com/glacier-node/api/nodes/:id/heartbeat"
TEE:
  IpfsURL: "https://greenfield.onebitdev.com/ipfs/"
EOF
check_status

echo -e "\n${YELLOW}[4/4] Running Glacier Verifier...${NC}"
docker run -d -e PRIVATE_KEY="${PRIVATE_KEY}" --name glacier-verifier docker.io/glaciernetwork/glacier-verifier:v0.0.2
check_status

echo -e "\n${YELLOW}Checking logs...${NC}"
echo "To view logs, run: docker logs -f glacier-verifier"

echo -e "\n${GREEN}Installation Complete!${NC}"
echo "================================================================"
echo -e "${YELLOW}Thank you for installing Glacier Verifier Node${NC}"
echo -e "${YELLOW}Wait for 30 minutes - 1 hours until show your Node${NC}"
echo -e "${YELLOW}Visit https://docs.glacier.io/ for more information${NC}"
echo "================================================================"