#!/usr/bin/env bash
# Sai do script se houver algum erro
set -o errexit

# Instala o uv e sincroniza apenas as dependências de produção.
pip install --upgrade uv
uv sync --locked --no-dev

# Coleta os arquivos estáticos
uv run --no-sync python manage.py collectstatic --no-input

# Aplica as migrações
uv run --no-sync python manage.py migrate