FROM mcr.microsoft.com/devcontainers/python:3.12

# install taplo
RUN curl -fsSL https://github.com/tamasfe/taplo/releases/latest/download/taplo-linux-aarch64.gz \
  | gzip -d - | install -m 755 /dev/stdin /usr/local/bin/taplo

# prepare for lefthook
RUN curl -1sLf 'https://dl.cloudsmith.io/public/evilmartians/lefthook/setup.deb.sh' | sudo -E bash

# install tools from apt
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
  --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
  apt update && \
  apt install -y supervisor lefthook

# install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv
ENV UV_CACHE_DIR=/opt/uv_cache/
ENV UV_LINK_MODE=copy

# install nodejs
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
ENV NVM_DIR="/usr/local/share/nvm"
ENV NODE_VERSION=22.11.0
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/usr/local/share/nvm/versions/node/v${NODE_VERSION}/bin:${PATH}"

# user 'vscode' is already created by the base image