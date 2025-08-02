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

## Files

- `0-world_wide_web` - Bash script to audit domain subdomains
- `README.md` - This file
