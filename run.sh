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

script_dir=$(dirname "$0")
cd "$script_dir/projeto-copybase"
docker-compose up -d
docker-compose logs
check_status

echo "Iniciando docker-compose front-end..."
cd "$script_dir/projeto-copybase-frontend"
docker-compose up -d
check_status

echo "Ambos os containers foram iniciados com sucesso."
