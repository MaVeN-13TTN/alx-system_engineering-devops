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

## Resources

- [Introduction to load-balancing and HAproxy](https://www.digitalocean.com/community/tutorials/an-introduction-to-haproxy-and-load-balancing-concepts)
- [HTTP header](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers)
- [Debian/Ubuntu HAProxy packages](https://haproxy.debian.net/)

## Repository

- **GitHub repository:** alx-system_engineering-devops
- **Directory:** 0x0F-load_balancer
