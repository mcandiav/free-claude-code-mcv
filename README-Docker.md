# Free Claude Code Docker

Dockerizacion local de Free Claude Code para ejecutar el proxy sin instalar Python, uv ni dependencias en Windows base.

## Objetivo

Ejecutar Free Claude Code como contenedor Docker local para que Claude Code pueda comunicarse con proveedores externos compatibles, incluyendo NVIDIA NIM.

## Estado validado

- Sistema host: Windows 11 Pro.
- Ruta local de trabajo: D:\Dockers\free-claude-code.
- Imagen construida: free-claude-code:local.
- Contenedor validado: fcc-proxy.
- Puerto publicado: 8082.
- Healthcheck validado: http://localhost:8082/health.
- Respuesta validada: {"status":"healthy"}.

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

## Seguridad

No subir `.env` al repositorio.

El archivo `.env.docker.example` no debe contener claves reales.

## Notas

Esta dockerizacion evita instalar Python, uv o Free Claude Code directamente en Windows base.
