#!/bin/bash

# Usa caminhos relativos baseados na localização do script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

echo "Atualizando arquivos index.ts..."

# Encontra todas as pastas de pessoas (excluindo pastas especiais)
find "$ROOT_DIR" -mindepth 1 -maxdepth 1 -type d | while read -r PERSON_DIR; do
  # Ignora diretórios especiais
  PERSON_NAME=$(basename "$PERSON_DIR")
  if [[ "$PERSON_NAME" == "node_modules" || "$PERSON_NAME" == "3-scripts" || "$PERSON_NAME" == ".git" ]]; then
    continue
  fi
  
  echo "Processando pasta: $PERSON_NAME"
  
  # Para cada pasta de dificuldade dentro da pasta da pessoa
  for DIFF_DIR in "$PERSON_DIR"/*; do
    if [ -d "$DIFF_DIR" ]; then
      DIFF_NAME=$(basename "$DIFF_DIR")
      
      # Verifica se é uma pasta de dificuldade válida
      if [[ "$DIFF_NAME" == "0-easy" || "$DIFF_NAME" == "1-medium" || "$DIFF_NAME" == "2-hard" ]]; then
        echo "  Atualizando index.ts para $PERSON_NAME/$DIFF_NAME..."
        
        # Início do arquivo index.ts
        echo "// Arquivo gerado automaticamente - exporta todas as funções execute()" > "$DIFF_DIR/index.ts"
        echo "// Pasta: $PERSON_NAME/$DIFF_NAME" >> "$DIFF_DIR/index.ts"
        echo "" >> "$DIFF_DIR/index.ts"
        
        # Para cada arquivo .ts no diretório (exceto index.ts)
        find "$DIFF_DIR" -maxdepth 1 -name "*.ts" | while read -r FILE; do
          FILENAME=$(basename "$FILE" .ts)
          
          # Ignora o próprio index.ts
          if [ "$FILENAME" != "index" ]; then
            # Extrai o ID do problema (assumindo formato: ID-nome-do-problema.ts)
            PROBLEM_ID=$(echo "$FILENAME" | cut -d'-' -f1)
            
            # Verifica se o arquivo contém uma função execute()
            if grep -q "function execute()" "$FILE" || grep -q "export function execute()" "$FILE"; then
              # Adiciona a exportação da função execute como solutionID
              echo "export { execute as solution$PROBLEM_ID } from './$FILENAME';" >> "$DIFF_DIR/index.ts"
            else
              echo "// Aviso: Arquivo $FILENAME não contém função execute()" >> "$DIFF_DIR/index.ts"
            fi
          fi
        done
        
        echo "" >> "$DIFF_DIR/index.ts"
        echo "// Fim das exportações automáticas" >> "$DIFF_DIR/index.ts"
      fi
    fi
  done
done

echo "Todos os arquivos index.ts foram atualizados com sucesso!"