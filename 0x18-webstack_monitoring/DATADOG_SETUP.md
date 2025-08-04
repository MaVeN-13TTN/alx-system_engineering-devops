# Datadog Setup Guide

## Step-by-Step Instructions for Task 0

### 1. Sign up for Datadog Account

1. Go to https://www.datadoghq.com/
2. Click "Get Started Free" or "Sign Up"
3. **Important**: Make sure you're using the US website (https://app.datadoghq.com)
4. Choose **US1** region during setup
5. Complete the registration process

### 2. Get Your API Key

1. Once logged in, navigate to **Organization Settings**
2. Go to **API Keys** section
3. Copy your API key (starts with a long string of characters)
4. Keep this secure - you'll need it for installation

### 3. Create Application Key

1. In the same Organization Settings area
2. Go to **Application Keys** section
3. Click "New Key"
4. Give it a name (e.g., "webstack-monitoring")
5. Copy the application key
6. Save both API key and Application key securely

### 4. Install Datadog Agent on web-01 Server

#### Method 1: Using the provided script

```bash
# Set your API key as environment variable
export DD_API_KEY="your_api_key_here"

# Run the installation script
./0-datadog_install.sh
```

#### Method 2: Manual installation

```bash
# SSH into your web-01 server
ssh ubuntu@18.212.71.220

# Run the one-line installer
DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=your_api_key_here DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"
```

### 5. Configure Hostname (if needed)

If your server doesn't appear with the correct hostname in Datadog:

1. Edit the Datadog configuration:

```bash
sudo vim /etc/datadog-agent/datadog.yaml
```

2. Find the hostname line and set it:

```yaml
hostname: 1300052-web-01
```

3. Restart the agent:

```bash
sudo systemctl restart datadog-agent
```

### 6. Verify Installation

1. Check agent status:

```bash
sudo datadog-agent status
```

2. Check if data is being sent:

```bash
sudo datadog-agent check
```

3. In Datadog web interface:
   - Go to Infrastructure → Host Map
   - Look for your server named "1300052-web-01"

### 7. API Validation

You can validate your setup using Datadog's API:

```bash
curl -X GET "https://api.datadoghq.com/api/v1/hosts" \
-H "Content-Type: application/json" \
-H "DD-API-KEY: your_api_key" \
-H "DD-APPLICATION-KEY: your_app_key"
```

### 8. Submit Keys to Intranet

1. Copy your API key
2. Copy your Application key
3. Paste both in your ALX Intranet user profile as requested

## Troubleshooting

### Agent Not Starting

```bash
# Check service status
sudo systemctl status datadog-agent

# Check logs
sudo tail -f /var/log/datadog/agent.log
```

### Host Not Appearing in Datadog

- Wait 5-10 minutes for data to appear
- Check hostname configuration
- Verify API key is correct
- Ensure network connectivity

### Common Issues

1. **Wrong region**: Make sure you're using US1 region
2. **Invalid API key**: Double-check the key from your Datadog account
3. **Firewall issues**: Ensure outbound connections to Datadog are allowed
4. **Hostname conflicts**: Set explicit hostname in configuration

## Important Notes

- Keep your API and Application keys secure
- The free tier has limitations but is sufficient for this project
- Data may take a few minutes to appear in Datadog dashboard
- The agent will automatically start collecting system metrics once installed
