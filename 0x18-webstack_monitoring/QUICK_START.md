# Task 0 - Quick Start Summary

## Files Created:

- `0-datadog_install.sh` - Installation script for Datadog agent
- `validate_datadog.sh` - Script to validate installation
- `check_datadog_api.sh` - Script to check if host appears in Datadog API
- `DATADOG_SETUP.md` - Complete setup guide
- `README.md` - Updated with task information

## Quick Steps to Complete Task 0:

### 1. Sign up for Datadog

- Go to https://app.datadoghq.com (US site)
- Sign up and select US1 region
- Get your API key and create an Application key

### 2. Install on web-01 server

```bash
# SSH to your server
ssh ubuntu@18.212.71.220

# Set your API key
export DD_API_KEY="your_actual_api_key_here"

# Run the installation
DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=$DD_API_KEY DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"
```

### 3. Configure hostname (if needed)

```bash
# Edit config file
sudo nano /etc/datadog-agent/datadog.yaml

# Add this line:
hostname: 1300052-web-01

# Restart agent
sudo systemctl restart datadog-agent
```

### 4. Validate installation

```bash
# Check status
sudo datadog-agent status

# Or use our validation script
./validate_datadog.sh
```

### 5. Check API (optional)

```bash
# Set your keys
export DD_API_KEY="your_api_key"
export DD_APP_KEY="your_app_key"

# Run the check
./check_datadog_api.sh
```

### 6. Submit to Intranet

- Copy your API key
- Copy your Application key
- Paste both in your ALX Intranet user profile

## Expected Result:

Your server should appear in Datadog dashboard as "1300052-web-01" within 5-10 minutes of installation.
