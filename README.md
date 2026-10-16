# Template Django com Django REST Framework e uv

Template de uma API REST com Django e Django REST Framework, configurada para
usar [uv](https://docs.astral.sh/uv/) na gestão de dependências e ambientes
Python. O projeto inclui configuração para desenvolvimento local com SQLite e
deploy com PostgreSQL, além de autenticação, documentação Swagger e suporte
opcional ao Cloudinary.

## Requisitos

- Python 3.14 (versão selecionada em `.python-version`; o projeto aceita Python
  3.10 ou superior)
- [uv](https://docs.astral.sh/uv/getting-started/installation/)

## Instalação e configuração

1. Crie um novo repositório a partir deste template.
2. Instale as dependências e crie o ambiente virtual:

   ```sh
   uv sync --all-groups
   ```

   Ou use `make sync`.

3. Crie o arquivo `.env` com base no exemplo e ajuste as variáveis:

   ```sh
   cp .env.example .env
   ```

4. Execute o servidor de desenvolvimento:

   ```sh
   uv run python manage.py runserver 127.0.0.1:8000
   ```

   Ou use `make dev`. A API estará disponível em
   `http://127.0.0.1:8000/api/`.

## Comandos úteis

O `Makefile` fornece atalhos que executam os comandos dentro do ambiente gerido
por uv:

- `make sync`: sincroniza o ambiente com `uv.lock`, incluindo dependências de
  desenvolvimento.
- `make add package=PACOTE` / `make add-dev package=PACOTE`: adiciona uma
  dependência de produção ou desenvolvimento.
- `make migrate`: cria migrações, aplica-as e atualiza o diagrama `core.png`.
- `make createsuperuser`, `make shell`, `make shellp` e `make test`: comandos
  comuns do Django.
- `make check-django`: verifica a configuração do Django.
- `make loaddata` e `make dumpdata`: importa ou exporta dados.
- `make cria-api args=ENTIDADE`: executa o gerador de arquivos da API.
- `make check` / `make lint`, `make lint-fix` e `make format`: verifica ou
  formata o código com Ruff.

O arquivo `uv.lock` registra as versões resolvidas das dependências. Após
alterar dependências, atualize-o com `uv lock` e sincronize o ambiente com
`uv sync --all-groups`.

## Deploy

O `build.sh` instala uv, sincroniza as dependências de produção a partir do
lockfile, coleta os arquivos estáticos e aplica as migrações. O `Procfile`
executa o Gunicorn usando o ambiente criado pelo uv.

## Licença

Este projeto está licenciado sob a [Licença GPL](https://www.gnu.org/licenses/gpl-3.0.html).
