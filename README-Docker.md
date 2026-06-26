# Free Claude Code Docker

Dockerizacion local de Free Claude Code para ejecutar el proxy sin instalar Python, uv ni dependencias en Windows base.

## Objetivo

Ejecutar Free Claude Code como contenedor Docker local para que Claude Code pueda comunicarse con proveedores externos compatibles, incluyendo NVIDIA NIM.

## Estado validado

Estado final: operativo y cerrado funcionalmente al 2026-06-26.

- Sistema host: Windows 11 Pro.
- Ruta local de trabajo: D:\dockers\free-claude-code.
- Imagen construida: free-claude-code:local.
- Contenedor validado: fcc-proxy.
- Puerto publicado solo localmente: 127.0.0.1:8082->8082/tcp.
- Healthcheck validado: http://localhost:8082/health.
- Respuesta validada: {"status":"healthy"}.
- Admin UI validado: http://127.0.0.1:8082/admin.

## Archivos Docker agregados

- Dockerfile
- docker-compose.yml
- .env.docker.example
- README-Docker.md

## Uso

Copiar el ejemplo de entorno:

```powershell
Copy-Item .env.docker.example .env
```

Editar `.env` y completar la clave local requerida.

Construir y levantar:

```powershell
docker compose up -d --build
```

Verificar salud:

```powershell
curl http://localhost:8082/health
```

Abrir el Admin UI:

```text
http://127.0.0.1:8082/admin
```

## Admin UI en Docker

El Admin UI original es local-only. En Docker puede quedar bloqueado con:

```json
{"detail":"Admin UI is local-only"}
```

La causa es que FastAPI puede detectar al cliente como IP de la red bridge Docker, no como loopback real.

La correccion operativa aplicada requiere dos condiciones:

1. Publicar el puerto solo en loopback del host.
2. Habilitar explicitamente el acceso Docker local con `FCC_ADMIN_ALLOW_DOCKER=true`.

El `docker-compose.yml` debe mantener:

```yaml
ports:
  - "127.0.0.1:8082:8082"
```

El `.env` local debe incluir:

```env
FCC_ADMIN_ALLOW_DOCKER=true
```

Ademas, en la instalacion local se aplico un parche en `api/admin_routes.py` para mantener la validacion loopback y permitir red privada/local solo cuando `FCC_ADMIN_ALLOW_DOCKER=true`.

## Seguridad

No subir `.env` al repositorio.

El archivo `.env.docker.example` no debe contener claves reales.

El puerto del proxy debe publicarse solo en `127.0.0.1`.

No exponer `/admin` por LAN, Cloudflare, Tailscale ni dominio externo sin nueva revision de seguridad.

## Cierre

Proyecto operativo en el Notebook ACER. No quedan pendientes bloqueantes para el uso local de Claude Code mediante Free Claude Code Docker y NVIDIA NIM.

## Notas

Esta dockerizacion evita instalar Python, uv o Free Claude Code directamente en Windows base.
