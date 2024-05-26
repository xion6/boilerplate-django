FROM python:3.12-bullseye AS builder

ENV PYTHONUNBUFFERED 1

# Install dependencies
WORKDIR /app
COPY requirements.lock /tmp/pip-tmp/
RUN pip3 --disable-pip-version-check --no-cache-dir install -r /tmp/pip-tmp/requirements.lock \
   && rm -rf /tmp/pip-tmp


FROM builder as dev-env
EXPOSE 8000

RUN <<EOF
apt-get update
apt install vim curl -y
apt clean
EOF

RUN <<EOF
addgroup --system docker
adduser --system --shell /bin/bash --ingroup docker vscode
EOF

# install Docker tools (cli, buildx, compose)
COPY --from=gloursdocker/docker / /

# Copy source files into application directory
COPY --chown=app:app . /app

ENTRYPOINT ["python3"]