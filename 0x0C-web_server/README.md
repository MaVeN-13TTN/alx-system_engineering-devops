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

### 2-setup_a_domain_name

A file containing the domain name configured for the web server.

#### Description

This file contains the root domain name (without subdomain) that points to your web-01 server. The domain should be configured with proper DNS A records to route traffic to your server's IP address.

#### Content Format

```
yourdomain.tech
```

#### Requirements

- Domain name must be a .tech domain (can be obtained free through GitHub Student Pack)
- Must be root domain only (no www or other subdomains)
- DNS A record must point to your web-01 server IP address
- Domain must be registered with "Dotserve Inc" as the registrar

#### Setup Process

1. **Get GitHub Student Pack**: Access GitHub Student Developer Pack
2. **Claim .TECH Domain**: Use the free .tech domain benefit
3. **Register Domain**: Complete registration through .TECH Domains
4. **Configure DNS**: Set up A record pointing to your server IP
5. **Verify Setup**: Use `dig` command to verify DNS propagation
6. **Update File**: Add your domain name to this file

#### Verification

After setup, you can verify your domain with:

```bash
# Check DNS resolution
dig yourdomain.tech

# Test web server response
curl yourdomain.tech

# Verify registrar (should show "Dotserve Inc")
# Check at: https://whois.whoisxmlapi.com/
```

#### Example

```bash
$ cat 2-setup_a_domain_name
myschool.tech

$ dig myschool.tech
; <<>> DiG 9.10.6 <<>> myschool.tech
;; ANSWER SECTION:
myschool.tech.  7199    IN  A   184.72.193.201
```

#### Notes

- DNS propagation can take 1-2 hours
- Make sure to update your GitHub profile with the domain
- Verify the registrar shows as "Dotserve Inc"

### 3-redirection

A Bash script that configures nginx with a 301 redirect for the `/redirect_me` path.

#### Description

This script builds upon the nginx installation and adds a 301 redirect configuration. When users access `/redirect_me`, they will be permanently redirected to a YouTube video URL.

#### Usage

```bash
sudo ./3-redirection
```

#### Features

- ✅ Complete nginx installation and setup
- ✅ Creates "Hello World!" index page
- ✅ Configures 301 Moved Permanently redirect for `/redirect_me`
- ✅ Uses `sed` to modify nginx configuration
- ✅ Tests nginx configuration before starting
- ✅ Starts and enables nginx service

#### What it does

1. Updates Ubuntu package list
2. Installs nginx web server
3. Creates basic "Hello World!" index page
4. Adds 301 redirect configuration using `sed`
5. Tests nginx configuration for syntax errors
6. Starts nginx service
7. Enables nginx to start on boot

#### Redirect Configuration

The script configures nginx to redirect `/redirect_me` to:

```
https://www.youtube.com/watch?v=QH2-TGUlwu4
```

#### Testing

After running the script, test the redirect with:

```bash
# Test the redirect (should return 301)
curl -sI YOUR_SERVER_IP/redirect_me/

# Expected response headers:
# HTTP/1.1 301 Moved Permanently
# Location: https://www.youtube.com/watch?v=QH2-TGUlwu4
```

#### Example Output

```bash
$ curl -sI 34.198.248.145/redirect_me/
HTTP/1.1 301 Moved Permanently
Server: nginx/1.4.6 (Ubuntu)
Date: Tue, 21 Feb 2017 21:36:04 GMT
Content-Type: text/html
Content-Length: 193
Connection: keep-alive
Location: https://www.youtube.com/watch?v=QH2-TGUlwu4
```

#### Technical Details

- Uses `sed` to insert location block into nginx default site configuration
- Adds the redirect rule after the `listen 80 default_server;` line
- Implements proper nginx `return 301` syntax
- Includes configuration testing before service restart

#### Requirements

- Ubuntu server with sudo privileges
- Internet connection for package downloads
- No existing conflicting web server configuration

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
