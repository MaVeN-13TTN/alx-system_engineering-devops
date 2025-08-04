#!/usr/bin/env bash
# Check if host appears in Datadog via API

# Check if API key and App key are provided
if [ -z "$DD_API_KEY" ] || [ -z "$DD_APP_KEY" ]; then
    echo "Usage: DD_API_KEY=your_api_key DD_APP_KEY=your_app_key ./check_datadog_api.sh"
    echo ""
    echo "Or export the variables:"
    echo "export DD_API_KEY=your_api_key"
    echo "export DD_APP_KEY=your_app_key"
    echo "./check_datadog_api.sh"
    exit 1
fi

echo "Checking Datadog API for hosts..."

# Make API call to get hosts
if response=$(curl -s -X GET "https://api.datadoghq.com/api/v1/hosts" \
    -H "Content-Type: application/json" \
    -H "DD-API-KEY: $DD_API_KEY" \
    -H "DD-APPLICATION-KEY: $DD_APP_KEY"); then
    echo "✓ API call successful"
    
    # Check if response contains our host
    if echo "$response" | grep -q "1300052-web-01\|web-01"; then
        echo "✓ Host found in Datadog!"
        echo "Host details:"
        echo "$response" | grep -A 5 -B 5 "web-01" || echo "$response" | head -20
    else
        echo "✗ Host not found in Datadog yet"
        echo "This might be normal if you just installed the agent"
        echo "Wait 5-10 minutes and try again"
        echo ""
        echo "Response preview:"
        echo "$response" | head -10
    fi
else
    echo "✗ API call failed"
    echo "Check your API key and application key"
fi
