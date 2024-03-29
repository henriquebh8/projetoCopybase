#!/bin/bash

check_status() {
  if [ $? -eq 0 ]; then
    echo "Docker-compose iniciado com sucesso."
  else
    echo "Erro ao iniciar docker-compose. Verifique o log para mais detalhes."
    docker-compose logs
    exit 1
  fi
}

echo "Iniciando docker-compose service..."

# Armazena o diretório atual antes de mudar
original_dir=$(pwd)
script_dir=$(dirname "$0")

# Mudança para o diretório do serviço e iniciação do docker-compose
cd "$script_dir/projeto-copybase"
docker-compose up -d
docker-compose logs
check_status

# Volta para o diretório original antes de iniciar o processo do front-end
cd "$original_dir"

echo "Iniciando docker-compose front-end..."

# Verifica se o diretório do front-end existe antes de tentar mudar para ele
if [ -d "$script_dir/projeto-copybase-frontend" ]; then
  cd "$script_dir/projeto-copybase-frontend"
  docker-compose up -d
  check_status
else
  echo "Erro: Diretório $script_dir/projeto-copybase-frontend não encontrado."
  exit 1
fi

echo "Ambos os containers foram iniciados com sucesso."
