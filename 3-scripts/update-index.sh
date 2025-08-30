#!/bin/bash

# Diretórios com problemas
DIRS=("0-easy" "1-medium" "2-hard")

for DIR in "${DIRS[@]}"; do
  echo "Atualizando index.ts para $DIR..."
  
  # Início do arquivo index.ts
  echo "// Arquivo gerado automaticamente - exporta todas as funções execute()" > "/home/hungaro/projetos/leet-code-problems/$DIR/index.ts"
  echo "" >> "/home/hungaro/projetos/leet-code-problems/$DIR/index.ts"
  
  # Para cada arquivo .ts no diretório (exceto index.ts)
  for FILE in "/home/hungaro/projetos/leet-code-problems/$DIR"/*.ts; do
    FILENAME=$(basename "$FILE" .ts)
    
    # Ignora o próprio index.ts
    if [ "$FILENAME" != "index" ]; then
      # Extrai o ID do problema (assumindo formato: ID-nome-do-problema.ts)
      PROBLEM_ID=$(echo "$FILENAME" | cut -d'-' -f1)
      
      # Verifica se o arquivo contém uma função execute()
      if grep -q "function execute()" "$FILE" || grep -q "export function execute()" "$FILE"; then
        # Adiciona a exportação da função execute como solutionID
        echo "export { execute as solution$PROBLEM_ID } from './$FILENAME';" >> "/home/hungaro/projetos/leet-code-problems/$DIR/index.ts"
      else
        echo "// Aviso: Arquivo $FILENAME não contém função execute()" >> "/home/hungaro/projetos/leet-code-problems/$DIR/index.ts"
      fi
    fi
  done
  
  echo "" >> "/home/hungaro/projetos/leet-code-problems/$DIR/index.ts"
  echo "// Fim das exportações automáticas" >> "/home/hungaro/projetos/leet-code-problems/$DIR/index.ts"
done

echo "Todos os arquivos index.ts foram atualizados com sucesso!"