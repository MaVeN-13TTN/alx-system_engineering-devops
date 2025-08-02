# 0x10. HTTPS SSL

## Learning Objectives

At the end of this project, you are expected to be able to explain to anyone, without the help of Google:

### General

- What is HTTPS SSL 2 main roles
- What is the purpose encrypting traffic
- What SSL termination means

## Tasks

### 0. World wide web

Configure your domain zone so that the subdomain www points to your load-balancer IP (lb-01). Let's also add other subdomains to make our life easier, and write a Bash script that will display information about subdomains.

**Requirements:**

- Add the subdomain www to your domain, point it to your lb-01 IP
- Add the subdomain lb-01 to your domain, point it to your lb-01 IP
- Add the subdomain web-01 to your domain, point it to your web-01 IP
- Add the subdomain web-02 to your domain, point it to your web-02 IP
- Your Bash script must accept 2 arguments: domain (mandatory) and subdomain (optional)
- Output format: `The subdomain [SUB_DOMAIN] is a [RECORD_TYPE] record and points to [DESTINATION]`
- When only domain is provided, display info for subdomains: www, lb-01, web-01, web-02 (in this order)
- When domain and subdomain are provided, display info for the specified subdomain
- Must use awk and at least one Bash function
- Ignore shellcheck case SC2086

### Usage

To use the script, pass the domain as the first argument. Optionally, you can provide a specific subdomain as the second argument.

**Examples:**

To check all default subdomains (`www`, `lb-01`, `web-01`, `web-02`):

```bash
./0-world_wide_web your_domain.com
```

To check a specific subdomain:

```bash
./0-world_wide_web your_domain.com www
```

### 1. HAProxy SSL termination

Configure HAProxy to handle encrypted traffic, decrypt it, and pass it on to the backend web servers.

**Requirements:**

- HAProxy must be listening on port TCP 443
- HAProxy must be accepting SSL traffic
- HAProxy must serve encrypted traffic that will return the / of your web server
- When querying the root of your domain name, the page returned must contain "ALX"
- Share your HAProxy config as an answer file (/etc/haproxy/haproxy.cfg)
- The file `1-haproxy_ssl_termination` must be your HAProxy configuration file
- Make sure to install HAProxy 1.5 or higher (SSL termination is not available before v1.5)

**Setup Steps:**

1. **Install Certbot** on the load balancer:

   ```bash
   sudo apt update && sudo apt install -y certbot
   ```

2. **Stop HAProxy temporarily** and obtain SSL certificate:

   ```bash
   sudo systemctl stop haproxy
   sudo certbot certonly --standalone -d www.your_domain.com --non-interactive --agree-tos --email admin@your_domain.com
   ```

3. **Prepare certificate for HAProxy**:

   ```bash
   sudo mkdir -p /etc/haproxy/certs
   sudo cat /etc/letsencrypt/live/www.your_domain.com/fullchain.pem /etc/letsencrypt/live/www.your_domain.com/privkey.pem > /etc/haproxy/certs/www.your_domain.com.pem
   sudo chmod 600 /etc/haproxy/certs/www.your_domain.com.pem
   ```

4. **Deploy HAProxy configuration** and restart:
   ```bash
   sudo cp 1-haproxy_ssl_termination /etc/haproxy/haproxy.cfg
   sudo systemctl start haproxy
   ```

**Testing:**

- Test HTTPS: `curl https://www.your_domain.com` should return "ALX"
- Test HTTP redirect: `curl -I http://www.your_domain.com` should return 301 redirect to HTTPS

## Files

- `0-world_wide_web` - Bash script to audit domain subdomains
- `1-haproxy_ssl_termination` - HAProxy configuration file with SSL termination
- `README.md` - This file
