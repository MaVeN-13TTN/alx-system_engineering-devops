#!/usr/bin/env bash
# Validate Datadog agent installation and configuration

echo "=== Datadog Agent Validation ==="

# Check if datadog-agent is installed
if command -v datadog-agent &> /dev/null; then
    echo "✓ Datadog agent is installed"
else
    echo "✗ Datadog agent is NOT installed"
    exit 1
fi

# Check if service is running
if systemctl is-active --quiet datadog-agent; then
    echo "✓ Datadog agent service is running"
else
    echo "✗ Datadog agent service is NOT running"
    echo "Try: sudo systemctl start datadog-agent"
fi

# Check if service is enabled
if systemctl is-enabled --quiet datadog-agent; then
    echo "✓ Datadog agent service is enabled"
else
    echo "✗ Datadog agent service is NOT enabled"
    echo "Try: sudo systemctl enable datadog-agent"
fi

# Check configuration file exists
if [ -f "/etc/datadog-agent/datadog.yaml" ]; then
    echo "✓ Datadog configuration file exists"
else
    echo "✗ Datadog configuration file is missing"
fi

# Show hostname configuration
echo ""
echo "=== Current Configuration ==="
if [ -f "/etc/datadog-agent/datadog.yaml" ]; then
    echo "Hostname setting:"
    grep -E "^hostname:" /etc/datadog-agent/datadog.yaml || echo "No explicit hostname set"
fi

echo ""
echo "System hostname: $(hostname)"

# Show agent status (requires sudo)
echo ""
echo "=== Agent Status ==="
echo "Run 'sudo datadog-agent status' for detailed status"
