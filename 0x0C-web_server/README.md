# 0x0C. Web Server

This directory contains scripts and configurations for web server management and file transfer operations.

## Project Overview

This project focuses on web server operations, particularly file transfer mechanisms using secure protocols. The main goal is to understand and implement secure file transfer methods between client and server systems.

## Files

### 0-transfer_file

A Bash script that securely transfers files from a client to a server using SCP (Secure Copy Protocol).

#### Description

This script automates the process of transferring files to a remote server using SSH key authentication. It's designed to be a simple yet secure way to deploy files to a web server.

#### Usage

```bash
./0-transfer_file PATH_TO_FILE IP USERNAME PATH_TO_SSH_KEY
```

#### Parameters

- **PATH_TO_FILE**: The local path to the file you want to transfer
- **IP**: The IP address of the destination server
- **USERNAME**: The username to connect with on the remote server
- **PATH_TO_SSH_KEY**: The path to the SSH private key for authentication

#### Features

- ✅ Parameter validation (requires exactly 4 parameters)
- ✅ Displays helpful usage message when parameters are missing
- ✅ Transfers files to the user's home directory (`~/`) on the remote server
- ✅ Disables strict host key checking for automated deployments
- ✅ Uses secure SSH key authentication

#### Example

```bash
# Create a test file
touch some_page.html

# Transfer the file to a server
./0-transfer_file some_page.html 8.8.8.8 ubuntu /path/to/private_key

# Verify the transfer
ssh ubuntu@8.8.8.8 -i /path/to/private_key 'ls ~/'
```

#### Error Handling

If fewer than 4 parameters are provided, the script will display:

```
Usage: 0-transfer_file PATH_TO_FILE IP USERNAME PATH_TO_SSH_KEY
```

#### Security Notes

- The script uses SSH key authentication for secure file transfer
- Strict host key checking is disabled (`-o StrictHostKeyChecking=no`) for automation
- Files are transferred directly to the user's home directory on the remote server

## Requirements

- Bash shell environment
- SSH client with SCP support
- Valid SSH private key for server authentication
- Network connectivity to the target server

## Author

Created as part of the ALX System Engineering & DevOps curriculum.

## Repository

- **GitHub repository**: alx-system_engineering-devops
- **Directory**: 0x0C-web_server
