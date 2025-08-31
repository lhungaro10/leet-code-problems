#!/bin/bash

# Usa caminhos relativos baseados na localização do script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
README_FILE="$ROOT_DIR/README.md"

# Verifica se está rodando no GitHub Actions
if [ -n "$GITHUB_ACTIONS" ]; then
  echo "Executando no GitHub Actions..."
fi

# Função para extrair nome do problema do arquivo
extract_problem_name() {
  local file=$1
  # Procura por comentário "Problem X: Nome do Problema"
  local problem_line=$(head -10 "$file" | grep -i "Problem [0-9]")
  if [ -n "$problem_line" ]; then
    # Extrai o nome após os dois pontos
    echo "$problem_line" | sed 's/.*: //' | sed 's/\/\/\|\/\*\|\*\///g' | xargs
  else
    # Se não encontrar, usa o nome do arquivo
    basename "$file" .ts | sed 's/^[0-9]*-//' | sed 's/-/ /g'
  fi
}

# Função para contar problemas resolvidos e listar nomes
count_solved_problems() {
  local dir=$1
  local solved=0
  local total=0
  local solved_names=()
  
  if [ -d "$dir" ]; then
    for file in "$dir"/*.ts; do
      if [ -f "$file" ] && [[ "$(basename "$file")" != "index.ts" ]]; then
        total=$((total + 1))
        # Verifica se o arquivo contém o comentário "solved" no topo
        if head -5 "$file" | grep -qi "solved"; then
          solved=$((solved + 1))
          problem_name=$(extract_problem_name "$file")
          solved_names+=("$problem_name")
        fi
      fi
    done
  fi
  
  # Junta os nomes dos problemas resolvidos com vírgula
  local names_str=""
  if [ ${#solved_names[@]} -gt 0 ]; then
    names_str=$(IFS=','; echo "${solved_names[*]}")
  fi
  
  echo "$solved $total $names_str"
}

# Função para atualizar o ranking no README
update_ranking() {
  echo "Atualizando ranking no README.md..."
  
  # Cria um arquivo temporário com o novo ranking
  local temp_file=$(mktemp)
  local in_ranking=false
  
  # Lê o README linha por linha
  while IFS= read -r line; do
    if [[ "$line" == "## Ranking" ]]; then
      echo "$line" >> "$temp_file"
      echo "" >> "$temp_file"
      echo "| Developer | Easy | Medium | Hard | Total |" >> "$temp_file"
      echo "|-----------|------|--------|------|-------|" >> "$temp_file"
      
      # Processa cada pasta de pessoa
      find "$ROOT_DIR" -mindepth 1 -maxdepth 1 -type d | while read -r PERSON_DIR; do
        PERSON_NAME=$(basename "$PERSON_DIR")
        if [[ "$PERSON_NAME" != "node_modules" && "$PERSON_NAME" != "3-scripts" && "$PERSON_NAME" != ".git" ]]; then
          
          # Conta problemas por dificuldade
          easy_data=$(count_solved_problems "$PERSON_DIR/0-easy")
          medium_data=$(count_solved_problems "$PERSON_DIR/1-medium")
          hard_data=$(count_solved_problems "$PERSON_DIR/2-hard")
          
          easy_solved=$(echo "$easy_data" | cut -d' ' -f1)
          easy_total=$(echo "$easy_data" | cut -d' ' -f2)
          
          medium_solved=$(echo "$medium_data" | cut -d' ' -f1)
          medium_total=$(echo "$medium_data" | cut -d' ' -f2)
          
          hard_solved=$(echo "$hard_data" | cut -d' ' -f1)
          hard_total=$(echo "$hard_data" | cut -d' ' -f2)
          
          total_solved=$((easy_solved + medium_solved + hard_solved))
          total_problems=$((easy_total + medium_total + hard_total))
          
          if [ $total_problems -gt 0 ]; then
            echo "| $PERSON_NAME | $easy_solved/$easy_total | $medium_solved/$medium_total | $hard_solved/$hard_total | $total_solved/$total_problems |" >> "$temp_file"
          fi
        fi
      done
      
      echo "" >> "$temp_file"
      
      # Adiciona as listas de problemas resolvidos
      echo "### Solved Problems by Developer" >> "$temp_file"
      echo "" >> "$temp_file"
      
      find "$ROOT_DIR" -mindepth 1 -maxdepth 1 -type d | while read -r PERSON_DIR; do
        PERSON_NAME=$(basename "$PERSON_DIR")
        if [[ "$PERSON_NAME" != "node_modules" && "$PERSON_NAME" != "3-scripts" && "$PERSON_NAME" != ".git" ]]; then
          
          # Conta problemas por dificuldade
          easy_data=$(count_solved_problems "$PERSON_DIR/0-easy")
          medium_data=$(count_solved_problems "$PERSON_DIR/1-medium")
          hard_data=$(count_solved_problems "$PERSON_DIR/2-hard")
          
          easy_solved=$(echo "$easy_data" | cut -d' ' -f1)
          medium_solved=$(echo "$medium_data" | cut -d' ' -f1)
          hard_solved=$(echo "$hard_data" | cut -d' ' -f1)
          total_solved=$((easy_solved + medium_solved + hard_solved))
          
          if [ $total_solved -gt 0 ]; then
            echo "#### $PERSON_NAME" >> "$temp_file"
            echo "" >> "$temp_file"
            
            # Easy problems
            if [ $easy_solved -gt 0 ]; then
              echo "**Easy Problems ($easy_solved):**" >> "$temp_file"
              easy_names=$(echo "$easy_data" | cut -d' ' -f3- | tr ',' '\n')
              while IFS= read -r problem; do
                if [ -n "$problem" ]; then
                  echo "- $problem" >> "$temp_file"
                fi
              done <<< "$easy_names"
              echo "" >> "$temp_file"
            fi
            
            # Medium problems
            if [ $medium_solved -gt 0 ]; then
              echo "**Medium Problems ($medium_solved):**" >> "$temp_file"
              medium_names=$(echo "$medium_data" | cut -d' ' -f3- | tr ',' '\n')
              while IFS= read -r problem; do
                if [ -n "$problem" ]; then
                  echo "- $problem" >> "$temp_file"
                fi
              done <<< "$medium_names"
              echo "" >> "$temp_file"
            fi
            
            # Hard problems
            if [ $hard_solved -gt 0 ]; then
              echo "**Hard Problems ($hard_solved):**" >> "$temp_file"
              hard_names=$(echo "$hard_data" | cut -d' ' -f3- | tr ',' '\n')
              while IFS= read -r problem; do
                if [ -n "$problem" ]; then
                  echo "- $problem" >> "$temp_file"
                fi
              done <<< "$hard_names"
              echo "" >> "$temp_file"
            fi
          fi
        fi
      done
      
      in_ranking=true
    elif [[ "$line" == "## How to contribute" ]]; then
      in_ranking=false
      echo "$line" >> "$temp_file"
    elif [[ "$in_ranking" == false ]]; then
      echo "$line" >> "$temp_file"
    fi
  done < "$README_FILE"
  
  # Substitui o README original
  mv "$temp_file" "$README_FILE"
}

# Atualiza o ranking no README
update_ranking

echo "Ranking atualizado no README.md!"