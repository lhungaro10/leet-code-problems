#!/bin/bash
source /home/hungaro/projetos/leet-code-problems/3-scripts/functions.sh

echo "Type the ID of the LeetCode problem, followed by [ENTER]:"
read problem_id

echo "Type the name of problem of leet-code, followed by [ENTER]:"
read name

# Usa a função para criar o arquivo
create_file "$problem_id" "$name" "1-medium"

echo "Problem file created successfully!"