#!/usr/bin/env bash
#
# init.sh - Sobe TODO o ambiente da oficina de Git com um comando.
#
#   ./init.sh
#
# O que ele faz, em ordem:
#   1. Garante o Docker Desktop rodando.
#   2. Sobe os tuneis Cloudflare (repo intelitech-tf).
#   3. Faz build e sobe os containers dev (3501) e prod (3500) (repo intelitech-front).
#   4. Garante o self-hosted runner do GitHub Actions rodando.
#   5. Checa saude local (portas) e publica (URLs).
#
# Pode rodar de novo quando quiser: e idempotente.

set -euo pipefail

# ------------------------------------------------------------------ cores/log
if [ -t 1 ]; then
  G=$'\033[32m'; Y=$'\033[33m'; R=$'\033[31m'; B=$'\033[34m'; N=$'\033[0m'
else
  G=""; Y=""; R=""; B=""; N=""
fi
step() { printf "\n${B}==>${N} %s\n" "$1"; }
ok()   { printf "    ${G}OK${N}  %s\n" "$1"; }
warn() { printf "    ${Y}!!${N}  %s\n" "$1"; }
die()  { printf "\n${R}ERRO:${N} %s\n" "$1" >&2; exit 1; }

# ------------------------------------------------------------------ caminhos
# Repo tf = diretorio deste script. Repo front = irmao ao lado.
TF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FRONT_DIR="$(cd "$TF_DIR/.." && pwd)/intelitech-front"
RUNNER_LABEL="actions.runner.intelitech-shop-intelitech-front.intelitech-mac"

[ -f "$TF_DIR/docker-compose.yml" ]    || die "docker-compose.yml nao encontrado em $TF_DIR"
[ -f "$FRONT_DIR/docker-compose.yml" ] || die "intelitech-front nao encontrado em $FRONT_DIR (clone ao lado do intelitech-tf)"

# ------------------------------------------------------------------ 1. Docker
step "Verificando Docker"
if ! command -v docker >/dev/null 2>&1; then
  die "Docker nao instalado. Instale o Docker Desktop e rode de novo."
fi
if ! docker info >/dev/null 2>&1; then
  warn "Docker daemon parado. Abrindo o Docker Desktop..."
  open -a Docker 2>/dev/null || die "Nao consegui abrir o Docker Desktop."
  printf "    aguardando o daemon"
  for _ in $(seq 1 40); do
    if docker info >/dev/null 2>&1; then break; fi
    printf "."; sleep 3
  done
  printf "\n"
  docker info >/dev/null 2>&1 || die "Docker nao subiu a tempo. Abra o Docker Desktop manualmente e rode de novo."
fi
ok "Docker rodando"

# ------------------------------------------------------------------ 2. Tuneis
step "Subindo tuneis Cloudflare (intelitech-tf)"
( cd "$TF_DIR" && docker compose up -d )
ok "cloudflare-tunnel-dev / cloudflare-tunnel-prod"

# ------------------------------------------------------------------ 3. Front
step "Build + subindo containers do site (intelitech-front)"
( cd "$FRONT_DIR" && docker compose up -d --build )
ok "intelitech-front-dev (:3501) / intelitech-front-prod (:3500)"

# ------------------------------------------------------------------ 4. Runner
step "Verificando self-hosted runner"
if pgrep -f "Runner.Listener" >/dev/null 2>&1; then
  ok "runner ja esta rodando"
elif [ -f "$HOME/Library/LaunchAgents/${RUNNER_LABEL}.plist" ]; then
  launchctl start "$RUNNER_LABEL" 2>/dev/null || true
  sleep 2
  if pgrep -f "Runner.Listener" >/dev/null 2>&1; then
    ok "runner iniciado"
  else
    warn "servico do runner existe mas nao confirmou. Veja: cd ~/actions-runner && ./svc.sh status"
  fi
else
  warn "runner NAO instalado. Deploy automatico por push nao vai funcionar."
  warn "Siga o passo 3 do intelitech-front/SETUP.md para instalar."
fi

# ------------------------------------------------------------------ 5. Saude
step "Checando saude local"
check_port() { # porta label
  if curl -fsS -o /dev/null --max-time 5 "http://localhost:$1/"; then
    ok "localhost:$1 ($2) responde 200"
  else
    warn "localhost:$1 ($2) NAO respondeu. Veja: docker ps / docker logs"
  fi
}
check_port 3501 "dev"
check_port 3500 "prod"

step "Checando URLs publicas (via tunel)"
check_url() { # url
  code="$(curl -s -o /dev/null -w '%{http_code}' --max-time 15 "$1" || echo 000)"
  if [ "$code" = "200" ]; then
    ok "$1 -> 200"
  else
    warn "$1 -> $code (o tunel pode levar alguns segundos; tente de novo)"
  fi
}
check_url "https://dev.intelitech.shop"
check_url "https://prod.intelitech.shop"

# ------------------------------------------------------------------ resumo
printf "\n${G}Ambiente pronto.${N}\n"
printf "  dev   -> https://dev.intelitech.shop   (push na branch dev)\n"
printf "  prod  -> https://prod.intelitech.shop  (push na branch main)\n\n"
printf "Containers no ar:\n"
docker ps --format '  {{.Names}}\t{{.Status}}\t{{.Ports}}' | grep -E 'intelitech|cloudflare' || true
printf "\n"
