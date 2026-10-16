.DEFAULT_GOAL := help

.PHONY: help sync lock upgrade tree add add-dev remove dev createsuperuser \
	pre-migrate migrate shell shellp test loaddata dumpdata cria-api \
	check check-django lint lint-fix format

help:
	@echo "Ambiente e dependências:"
	@echo "  make sync       Sincroniza o ambiente com uv.lock"
	@echo "  make lock       Atualiza o uv.lock"
	@echo "  make upgrade    Atualiza as dependências"
	@echo "  make tree       Exibe a árvore de dependências"
	@echo "  make add package=PACOTE"
	@echo "  make add-dev package=PACOTE"
	@echo "  make remove package=PACOTE"
	@echo ""
	@echo "Django:"
	@echo "  make dev        Inicia o servidor de desenvolvimento"
	@echo "  make migrate    Cria e aplica migrações e atualiza core.png"
	@echo "  make createsuperuser | shell | shellp | test"
	@echo "  make loaddata | dumpdata | cria-api args=ENTIDADE"
	@echo ""
	@echo "Qualidade:"
	@echo "  make check-django"
	@echo "  make check | lint | lint-fix | format"

sync:
	uv sync --all-groups

lock:
	uv lock

upgrade:
	uv lock --upgrade
	uv sync --all-groups

tree:
	uv tree

add:
	uv add $(package)

add-dev:
	uv add --dev $(package)

remove:
	uv remove $(package)

dev:
	uv run python manage.py runserver 127.0.0.1:8000

createsuperuser:
	uv run python manage.py createsuperuser

pre-migrate:
	uv run python manage.py makemigrations

migrate: pre-migrate
	uv run python manage.py migrate
	uv run python manage.py graph_models -S -g -o core.png core

shell:
	uv run python manage.py shell

shellp:
	uv run python manage.py shell_plus

test:
	uv run python manage.py test

loaddata:
	uv run python manage.py loaddata core.json

dumpdata:
	uv run python manage.py dumpdata --indent 2

cria-api:
	uv run python ./scripts/cria_api.py $(args)

check:
	uv run ruff check

check-django:
	uv run python manage.py check

lint: check

lint-fix:
	uv run ruff check --fix

format:
	uv run ruff format
