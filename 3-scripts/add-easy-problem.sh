#!/bin/bash
source "$(dirname "$0")/functions.sh"

echo "Digite o nome do contribuidor (pasta):"
read contributor

echo "Type the ID of the LeetCode problem, followed by [ENTER]:"
read problem_id

echo "Type the name of problem of leet-code, followed by [ENTER]:"
read name

# Usa a função para criar o arquivo
create_file "$problem_id" "$name" "0-easy" "$contributor"

echo "Problem file created successfully!"