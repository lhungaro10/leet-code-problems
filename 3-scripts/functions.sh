#!/bin/zsh

create_file() {
  local id=$1
  local name=$2
  local difficulty=$3
  
  # Normaliza o nome diretamente com a função bash
  local normalized_name=$(normalize_name_file "$id" "$name")
  
  # Cria o arquivo na pasta apropriada
  local directory="/home/hungaro/projetos/leet-code-problems/$difficulty"
  touch "$directory/$normalized_name"
  
  echo "Created file: $directory/$normalized_name"
  
  # Opcionalmente, preencha o arquivo com um template básico
  echo "// Problem ${id}: ${name}" > "$directory/$normalized_name"
  echo "export function solution() {" >> "$directory/$normalized_name"
  echo "  // Implemente sua solução aqui" >> "$directory/$normalized_name"
  echo "}" >> "$directory/$normalized_name"
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

