FROM python:3.14-slim-bookworm

WORKDIR /app

RUN python -m pip install --no-cache-dir --upgrade pip
RUN python -m pip install --no-cache-dir "uv>=0.11.0"
RUN uv --version

COPY pyproject.toml uv.lock README.md server.py .env.example ./
COPY api ./api
COPY cli ./cli
COPY config ./config
COPY core ./core
COPY messaging ./messaging
COPY providers ./providers

RUN uv sync --locked --no-dev

ENV FCC_OPEN_BROWSER=false
ENV FCC_ENV_FILE=/config/.env

EXPOSE 8082

CMD ["uv", "run", "uvicorn", "server:app", "--host", "0.0.0.0", "--port", "8082", "--timeout-graceful-shutdown", "5"]
