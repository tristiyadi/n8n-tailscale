#!/bin/bash

# Check if .env exists
if [ ! -f .env ]; then
    echo "Error: .env file not found!"
    echo "Please copy .env.example to .env and add your TS_AUTHKEY"
    exit 1
fi

echo "Starting Docker containers..."
docker compose up -d

echo "Waiting for Tailscale to be ready..."
# Wait a bit for tailscale to initialize
sleep 10

echo "Configuring Tailscale Funnel..."
# Ensure the serve config is active
docker compose exec tailscale tailscale funnel --bg http://127.0.0.1:5678

echo "---------------------------------------------------"
echo "Setup Complete!"
echo "tailscale status:"
docker compose exec tailscale tailscale status
echo "---------------------------------------------------"
echo "You can access n8n at the URL above (in the status output)."
