# 0x0F. Load balancer

This project focuses on implementing load balancing to improve web infrastructure redundancy and reliability.

## Background Context

You have been given 2 additional servers:

- gc-1300052-web-02 (54.165.239.199)
- gc-1300052-lb-01 (44.204.4.83)

The goal is to improve our web stack so that there is redundancy for our web servers. This will allow us to accept more traffic by doubling the number of web servers, and to make our infrastructure more reliable. If one web server fails, we will still have a second one to handle requests.

## Server Information

| Name           | Username | IP             | State   |
| -------------- | -------- | -------------- | ------- |
| 1300052-web-01 | ubuntu   | 18.212.71.220  | running |
| 1300052-web-02 | ubuntu   | 54.165.239.199 | running |
| 1300052-lb-01  | ubuntu   | 44.204.4.83    | running |

## Learning Objectives

- Understand load balancing concepts and algorithms
- Configure HAProxy for HTTP traffic distribution
- Implement redundancy and high availability
- Use custom HTTP headers for server identification
- Automate server configuration with Bash scripts

## Requirements

### General

- Allowed editors: vi, vim, emacs
- All files interpreted on Ubuntu 16.04 LTS
- All files should end with a new line
- A README.md file, at the root of the folder of the project, is mandatory
- All Bash script files must be executable
- Bash scripts must pass Shellcheck (version 0.3.7) without any error
- The first line of all Bash scripts should be exactly `#!/usr/bin/env bash`
- The second line of all Bash scripts should be a comment explaining what the script does

## Tasks

### 0. Double the number of webservers

**File:** `0-custom_http_response_header`

Configure web-02 to be identical to web-01. The script configures a brand new Ubuntu machine with:

- Nginx web server installation
- Custom HTTP response header `X-Served-By` with the hostname value
- Basic "Hello World!" page

**Requirements:**

- Configure Nginx so that its HTTP response contains a custom header
- The name of the custom HTTP header must be `X-Served-By`
- The value of the custom HTTP header must be the hostname of the server
- Script configures a brand new Ubuntu machine to meet requirements
- Ignore SC2154 for shellcheck

**Usage:**

```bash
sudo ./0-custom_http_response_header
```

**Testing:**

```bash
curl -sI [SERVER_IP] | grep X-Served-By
```

**Expected Output:**

```
X-Served-By: 1300052-web-01
X-Served-By: 1300052-web-02
```

### 1. Install your load balancer

**File:** `1-install_load_balancer`

Install and configure HAProxy on the lb-01 server to distribute traffic between web-01 and web-02.

**Requirements:**

- Configure HAProxy to send traffic to web-01 and web-02
- Distribute requests using a roundrobin algorithm
- Make sure that HAProxy can be managed via an init script
- Make sure that your servers are configured with the right hostnames: [STUDENT_ID]-web-01 and [STUDENT_ID]-web-02
- Write a Bash script that configures a new Ubuntu machine to respect above requirements

**Usage:**

```bash
sudo ./1-install_load_balancer
```

**Testing:**

```bash
# Test load balancer (should alternate between servers)
curl -Is [LOAD_BALANCER_IP]
curl -Is [LOAD_BALANCER_IP]
```

**Expected Output:**

```
# First request
HTTP/1.1 200 OK
Server: nginx/1.18.0 (Ubuntu)
X-Served-By: 1300052-web-01

# Second request
HTTP/1.1 200 OK
Server: nginx/1.18.0 (Ubuntu)
X-Served-By: 1300052-web-02
```

**Configuration Details:**

- **Load Balancer IP:** 44.204.4.83
- **Backend Servers:** web-01 (18.212.71.220), web-02 (54.165.239.199)
- **Algorithm:** Round-robin distribution
- **Health Checks:** HTTP GET / requests
- **Service Management:** systemctl/service commands supported

### 2. Add a custom HTTP header with Puppet

**File:** `2-puppet_custom_http_response_header.pp`

Automate the task of creating a custom HTTP header response using Puppet instead of Bash scripting.

**Requirements:**

- The name of the custom HTTP header must be `X-Served-By`
- The value of the custom HTTP header must be the hostname of the server Nginx is running on
- Write `2-puppet_custom_http_response_header.pp` so that it configures a brand new Ubuntu machine to meet requirements

**Puppet Resources Used:**

- `package`: Install nginx
- `exec`: Update package lists
- `file`: Configure nginx default site and create index.html
- `service`: Manage nginx service (running/enabled)

**Usage:**

```bash
# Validate syntax
puppet parser validate 2-puppet_custom_http_response_header.pp

# Test in dry-run mode
sudo puppet apply --noop 2-puppet_custom_http_response_header.pp

# Apply the manifest
sudo puppet apply 2-puppet_custom_http_response_header.pp
```

**Testing:**

```bash
curl -sI [SERVER_IP] | grep X-Served-By
```

**Expected Output:**

```
X-Served-By: 1300052-web-01
```

**Manifest Features:**

- **Idempotent:** Can be run multiple times safely
- **Dynamic Hostname:** Uses `${facts['hostname']}` for automatic server identification
- **Complete Configuration:** Handles package installation, file management, and service control
- **Proper Dependencies:** Ensures correct resource execution order
- **File Ownership:** Sets appropriate permissions for web files

## Resources

- [Introduction to load-balancing and HAproxy](https://www.digitalocean.com/community/tutorials/an-introduction-to-haproxy-and-load-balancing-concepts)
- [HTTP header](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers)
- [Debian/Ubuntu HAProxy packages](https://haproxy.debian.net/)

## Repository

- **GitHub repository:** alx-system_engineering-devops
- **Directory:** 0x0F-load_balancer
