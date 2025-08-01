# 0x13. Firewall

This project focuses on implementing firewall rules using UFW (Uncomplicated Firewall) to secure web servers.

## Background Context

Firewalls are essential security tools that control network traffic based on predetermined security rules. This project implements basic firewall configurations to protect web infrastructure while maintaining necessary service accessibility.

## Server Information

| Name           | Username | IP             | State   |
| -------------- | -------- | -------------- | ------- |
| 1300052-web-01 | ubuntu   | 18.212.71.220  | running |
| 1300052-web-02 | ubuntu   | 54.165.239.199 | running |
| 1300052-lb-01  | ubuntu   | 44.204.4.83    | running |

## Learning Objectives

- Understand firewall concepts and implementation
- Configure UFW (Uncomplicated Firewall) on Ubuntu
- Implement security best practices for web servers
- Learn proper firewall rule management
- Understand the importance of SSH access preservation

## Requirements

### General

- All files will be interpreted on Ubuntu 20.04 LTS
- All Bash script files must be executable
- A README.md file, at the root of the folder of the project, is mandatory
- All your Bash script files must pass Shellcheck (version 0.3.7) without any error
- The first line of all your Bash scripts should be exactly `#!/usr/bin/env bash`
- The second line of all your Bash scripts should be a comment explaining what the script does

## Tasks

### 0. Block all incoming traffic but

**File:** `0-block_all_incoming_traffic_but`

Configure UFW on web-01 to block all incoming traffic except for specific essential ports.

**Requirements:**

- Block all incoming traffic by default
- Allow incoming traffic on TCP port 22 (SSH)
- Allow incoming traffic on TCP port 443 (HTTPS SSL)
- Allow incoming traffic on TCP port 80 (HTTP)
- Share the UFW commands used

**UFW Commands Used:**

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw --force enable
```

**Configuration Details:**

- **Default Policy:** Deny all incoming, allow all outgoing
- **Allowed Ports:**
  - 22/tcp (SSH) - Critical for remote access
  - 80/tcp (HTTP) - Web service
  - 443/tcp (HTTPS SSL) - Secure web service
- **Security Level:** High - Only essential ports are open

**Testing:**

```bash
# Test firewall status
sudo ufw status numbered

# Test allowed services
curl http://18.212.71.220  # Should work
ssh ubuntu@18.212.71.220  # Should work

# Test blocked ports
telnet 18.212.71.220 8080  # Should fail/timeout
```

**Safety Notes:**

- ⚠️ **CRITICAL:** Always allow SSH (port 22) before enabling UFW to avoid lockout
- UFW blocks port 22 by default when installed
- Test firewall rules before applying to production systems
- Keep alternative access methods available when modifying firewall rules

### 1. Port forwarding

**File:** `100-port_forwarding`

Configure UFW to forward incoming traffic from port 8080 to port 80 using NAT (Network Address Translation) rules.

**Requirements:**

- Configure web-01 firewall to redirect port 8080/TCP to port 80/TCP
- Answer file should be a copy of the modified UFW configuration file
- Nginx should only listen on port 80, but respond to requests on both ports

**Implementation:**

- Modified `/etc/ufw/before.rules` to add NAT table rules
- Added PREROUTING rule to redirect port 8080 to port 80
- Enabled incoming traffic on port 8080 in UFW
- Used REDIRECT target for local port forwarding

**Configuration Details:**

```bash
# NAT table rules added to /etc/ufw/before.rules
*nat
:PREROUTING ACCEPT [0:0]
:POSTROUTING ACCEPT [0:0]

# Port forwarding rule: redirect port 8080 to port 80
-A PREROUTING -p tcp --dport 8080 -j REDIRECT --to-port 80

COMMIT
```

**Testing:**

```bash
# Test both ports return same content
curl -sI http://18.212.71.220:80   # Should work
curl -sI http://18.212.71.220:8080 # Should also work (forwarded)

# Verify nginx only listens on port 80
sudo ss -lpn | grep ':80\|:8080'
```

**Results:**

- ✅ Port 80: HTTP/1.1 200 OK (direct nginx)
- ✅ Port 8080: HTTP/1.1 200 OK (forwarded to port 80)
- ✅ Nginx only listening on port 80 as expected
- ✅ Port forwarding transparent to clients

## Debugging Tools

### Network Connectivity Testing

```bash
# Check open ports
netstat -lpn

# Test specific port connectivity
telnet TARGET_IP TARGET_PORT

# Check firewall rules
sudo ufw status verbose

# Monitor logs
sudo tail -f /var/log/ufw.log
```

### Service Status

```bash
# Check UFW service
sudo systemctl status ufw

# Check UFW is enabled
sudo ufw status

# Show all rules
sudo ufw show added
```

## Resources

- [What is a firewall](<https://en.wikipedia.org/wiki/Firewall_(computing)>)
- [UFW Documentation](https://help.ubuntu.com/community/UFW)
- [iptables vs UFW](https://www.digitalocean.com/community/tutorials/ufw-essentials-common-firewall-rules-and-commands)

## Repository

- **GitHub repository:** alx-system_engineering-devops
- **Directory:** 0x13-firewall
