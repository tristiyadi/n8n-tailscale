# n8n + Tailscale Automation

This setup runs n8n and Tailscale using Docker Compose, automatically exposing n8n via a Tailscale Funnel.

## Prerequisites

1.  **Tailscale Auth Key**:
    - Go to [Tailscale Keys](https://login.tailscale.com/admin/settings/keys).
    - Generate a **Reusable** key.
    - Add the tag `tag:container` (optional but recommended).

## Setup

1.  **Configure Environment**:
    - Copy the example environment file:
      ```bash
      cp .env.example .env
      ```
    - Edit `.env` and paste your `TS_AUTHKEY`.

2.  **Start and Configure**:
    - Run the start script:
      ```bash
      chmod +x start.sh
      ./start.sh
      ```
    - This script will:
      - Start the containers (n8n and tailscale).
      - Automatically configure `tailscale serve` and `funnel`.
      - Show you the status and URL.

## Accessing n8n

After the script finishes, you can access n8n at:
`https://n8n-server.<your-tailnet>.ts.net`

## Troubleshooting

- If `tailscale` commands fail, you can run them manually:
  ```bash
  docker compose exec tailscale tailscale serve --https=443 http://127.0.0.1:5678
  docker compose exec tailscale tailscale funnel 443 on
  ```
- To check logs:
  ```bash
  docker compose logs -f
  ```
