# Первоначальная настройка traefik

```sudo mkdir /etc/traefik```

```sudo touch /etc/traefik/acme.json```

```sudo chmod 600 /etc/traefik/acme.json```

```sudo nano /etc/traefik/traefik.yml```

### Содержимое traefik.yml:

```
global:
  checkNewVersion: false
  sendAnonymousUsage: false

entryPoints:
  web:
    address: :80/tcp
    http:
      redirections:
        entryPoint:
          to: websecure
  websecure:
    address: :443
    http:
      tls:
        certResolver: le
  traefik:
    address: :8080/tcp

providers:
  file:
    filename: /etc/traefik/traefik.yml
    watch: true
  docker:
    watch: true
    endpoint: 'unix:///var/run/docker.sock'
    exposedByDefault: false

api:
  dashboard: true
  insecure: true

certificatesResolvers:
  le:
    acme:
      email: email@yandex.ru
      storage: /etc/traefik/acme.json
      dnsChallenge:
        provider: cloudflare
http:
  middlewares:
    limit:
      rateLimit:
        average: 200
        period: 1m
    flight:
      inFlightReq:
        amount: 200
```
### Содержимое docker-compose.yml (в папке пользователя):
```
version: '3'

services:
  traefik:
    image: "traefik:v2.8"
    container_name: "traefik"
    ports:
      - "80:80"
      - "443:443"
      - "8080:8080"
    environment:
      - CF_API_EMAIL=email@yandex.ru
      - CF_API_KEY=global_token_here
      - CF_DNS_API_TOKEN=generete_token_with_dns
    volumes:
      - /etc/traefik:/etc/traefik
      - /var/run/docker.sock:/var/run/docker.sock:ro
```
