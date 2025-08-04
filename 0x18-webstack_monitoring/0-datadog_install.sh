#!/usr/bin/env bash
# Install Datadog agent on Ubuntu server

# Update package list
sudo apt-get update

# Download and install Datadog agent
DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=$DD_API_KEY DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"

# Start and enable the Datadog agent
sudo systemctl start datadog-agent
sudo systemctl enable datadog-agent

# Check agent status
sudo datadog-agent status
