#!/bin/bash

create_file() {
  local id=$1
  local name=$2
  local difficulty=$3
  local contributor=$4
  
  # Se não foi fornecido um contribuidor, pergunta
  if [ -z "$contributor" ]; then
    echo "Digite o nome do contribuidor (pasta):"
    read contributor
  fi
  
  # Normaliza o nome diretamente com a função bash
  local normalized_name=$(normalize_name_file "$id" "$name")
  
  # Usa caminho relativo baseado no diretório atual do script
  local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  local project_root="$(dirname "$script_dir")"
  local directory="$project_root/$contributor/$difficulty"
  
  # Cria o diretório se não existir
  mkdir -p "$directory"
  
  # Cria o arquivo
  touch "$directory/$normalized_name"
  
  echo "Created file: $directory/$normalized_name"
  
  # Preenche o arquivo com um template básico incluindo a função execute()
  cat > "$directory/$normalized_name" << EOL
// Problem ${id}: ${name}
export function solution() {
  
}

export function execute() {
  
}
EOL
}

normalize_name_file() {
  local id=$1
  local name=$2
  
  # Converte para minúsculas
  local lowercase_name=$(echo "$name" | tr '[:upper:]' '[:lower:]')
  
  # Remove caracteres especiais e substitui espaços por hífens
  local normalized_name=$(echo "$lowercase_name" | sed -e 's/[^a-z0-9 ]//g' -e 's/ \+/-/g' -e 's/-\+/-/g')
  
  # Retorna o nome formatado
  echo "${id}-${normalized_name}.ts"
}