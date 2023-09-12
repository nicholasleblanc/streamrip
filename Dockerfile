FROM python:3.11-slim-bookworm

# Configure Poetry
ENV POETRY_VERSION=1.6.1
ENV POETRY_HOME=/opt/poetry
ENV POETRY_VENV=/opt/poetry-venv
ENV POETRY_CACHE_DIR=/opt/.cache

WORKDIR /usr/src/app

# Install poetry
RUN apt update -y && apt upgrade -y && apt install curl -y
RUN curl -sSL https://install.python-poetry.org | python3 -
RUN /opt/poetry/bin/poetry config virtualenvs.create false
RUN apt remove curl -y

# Add `poetry` to PATH
ENV PATH="${PATH}:${POETRY_VENV}/bin"
ENV RIP_CONFIG_FILE="/config/config.toml"

# Install dependencies
COPY poetry.lock pyproject.toml ./
RUN /opt/poetry/bin/poetry install --no-root

COPY . .

# Install application
RUN pip3 install .

VOLUME /config
VOLUME /downloads
