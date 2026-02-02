# n8n + Tailscale Automation

This setup runs n8n and Tailscale using Docker Compose, automatically exposing n8n via a Tailscale Funnel.

## Prerequisites

1.  **Tailscale Auth Key**:
    - Go to [Tailscale Keys](https://login.tailscale.com/admin/settings/keys).
    - Generate a **Reusable** key.
    - Add the tag `tag:container` (optional but recommended).
    
2.  **Settings Dns And Generate Auth Key**
    https://login.tailscale.com/admin/dns
      - Setting DNS
        - MagicDNS -> Enable
        - HTTPS Certificate -> Enable
    https://login.tailscale.com/admin/settings/keys
      - Generate Auth keys

## Workflow / Cara Pakai

### 1. Pertama Kali (Fresh Install / Habis Clone)
Saat pertama kali download/clone repository ini, Docker container belum ada. Lakukan ini:

1.  **Buat file `.env`**:
    Copy file example dan isi dengan Auth Key Tailscale Anda.
    ```bash
    cp .env.example .env
    # Edit file .env dan masukkan TS_AUTHKEY
    ```
2. **Generate N8N Keys**
  - N8N_ENCRYPTION_KEY bisa generate key nya disini https://www.strongdm.com/tools/api-key-generator
3.  **Jalankan Script**:
    ```bash
    ./start.sh
    ```
    *Script ini akan otomatis download image, buat container, login tailscale, dan aktifkan funnel.*

### 2. Setelah Restart Komputer
Setelah restart, Docker biasanya akan otomatis menjalankan container (karena setting `restart: always`).
Namun, untuk memastikan Tailscale Funnel aktif kembali dengan benar, **cukup jalankan script yang sama lagi**:

```bash
./start.sh
```

*Script ini aman dijalankan berulang kali. Dia akan memastikan container nyala dan config funnel terpasang.*

## Accessing n8n

After the script finishes and Funnel on and, you can access n8n at:
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
