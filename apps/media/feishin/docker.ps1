#!/usr/bin/env pwsh

# 可以透過 host.docker.internal 連接到 host
# docker run -d --restart always --name feishin -p 9180:9180 --add-host=host.docker.internal:host-gateway ghcr.io/jeffvli/feishin:latest

# host 模式，可以直接使用 zerotier 等服務
docker run -d --restart always --name feishin --network host ghcr.io/jeffvli/feishin:latest
