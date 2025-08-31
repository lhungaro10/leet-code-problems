run:
    npx ts-node-dev main.ts
add-easy:
    ./3-scripts/add-easy-problem.sh
add-medium:
    ./3-scripts/add-medium-problem.sh
add-hard:
    ./3-scripts/add-hard-problem.sh
update-indexes:
    ./3-scripts/update-indexes.sh
update-ranking:
    ./3-scripts/update-ranking.sh
update-all:
    ./3-scripts/update-indexes.sh && ./3-scripts/update-ranking.sh