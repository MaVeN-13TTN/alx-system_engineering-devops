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

### 1-install_nginx_web_server

A Bash script that automatically installs and configures nginx web server on an Ubuntu machine.

#### Description

This script sets up nginx web server with a basic "Hello World!" page. It's designed to automate the initial nginx installation and configuration process on a fresh Ubuntu server.

#### Usage

```bash
sudo ./1-install_nginx_web_server
```

#### Features

- ✅ Updates package list before installation
- ✅ Installs nginx using apt-get with -y flag
- ✅ Configures nginx to listen on port 80 (default)
- ✅ Creates a simple "Hello World!" index page
- ✅ Starts nginx service automatically
- ✅ Enables nginx to start on boot

#### What it does

1. Updates the Ubuntu package list
2. Installs nginx web server
3. Creates an index.html file with "Hello World!" content
4. Starts the nginx service
5. Enables nginx to start automatically on system boot

#### Testing

After running the script, you can test it with:

```bash
# Test locally on the server
curl localhost

# Test from remote machine (replace IP with your server's IP)
curl YOUR_SERVER_IP

# Check HTTP headers
curl -sI YOUR_SERVER_IP
```

#### Expected Output

```
Hello World!
```

#### Requirements

- Ubuntu server with sudo privileges
- Internet connection for package downloads
- No existing conflicting web server on port 80

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
