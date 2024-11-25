# Glacier Node Auto Installation Script

This script automates the installation process of the Glacier Verifier Node, making it easy to set up and configure your node with minimal manual intervention.

## Prerequisites

- Ubuntu 20.04 LTS or higher
- Sudo privileges
- EVM Private Key
- BNB Testnet Token (for gas fees)

## Registration

Before installing, make sure to register [Glacier](https://www.glacier.io/points/?inviter=0xfFd16F9afc8A5465Ee3A8e3bc96AD2Fb05261a01)

## Get Testnet BNB

Before running the node, you need to get some testnet BNB for gas fees:

1. Visit [BNB Chain Testnet Faucet](https://www.bnbchain.org/en/testnet-faucet)
2. Connect your wallet
3. Request testnet BNB tokens
4. Wait for the tokens to appear in your wallet

## Quick Installation

Choose one of these methods to download and run the installation script:

Using `wget`:

```bash
wget https://raw.githubusercontent.com/Galkurta/Glacier/refs/heads/main/glacier.sh && chmod +x glacier.sh && sudo ./glacier.sh
```

Using `curl`:

```bash
curl -fsSL https://raw.githubusercontent.com/Galkurta/Glacier/refs/heads/main/glacier.sh -o glacier.sh && chmod +x glacier.sh && sudo ./glacier.sh
```

## What the Script Does

1. Installs Prerequisites:

   - Updates system packages
   - Configures firewall
   - Installs required dependencies

2. Installs Docker:

   - Docker Engine
   - Docker Compose
   - Checks Docker version

3. Sets up Glacier Node:

   - Creates necessary directories
   - Clones node bootstrap repository
   - Configures node settings

4. Runs Glacier Verifier:
   - Starts Docker container
   - Sets up configuration files
   - Initiates the verifier node

## Configuration

During installation, you'll be prompted to enter:

- Your EVM Private Key
- Custom port (default: 10801)

## Logs

To view the node logs after installation:

```bash
docker logs -f glacier-verifier
```

## Security Notice

- Keep your private key secure and never share it
- Ensure your server has proper security measures in place
- Regularly update your system and the node software

## Links

- [Official Documentation](https://docs.glacier.io/)
- [GitHub Repository](https://github.com/Galkurta/Glacier)
- [Registration Link](https://www.glacier.io/points/?inviter=0xfFd16F9afc8A5465Ee3A8e3bc96AD2Fb05261a01)
- [BNB Testnet Faucet](https://www.bnbchain.org/en/testnet-faucet)

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

If you find this script helpful, please consider giving it a star on GitHub!

## Contact

For support and updates, follow [@Galkurta](https://github.com/Galkurta)
