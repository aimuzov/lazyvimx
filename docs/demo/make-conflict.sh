#!/bin/sh
# Готовит sample-conflict/ — маленький git-репозиторий с настоящим
# мердж-конфликтом для гифки git.conflicts. Пересоздаётся с нуля.
# Файл нарочно не-кодовый: LSP на нём не стартует и не сыплет
# синтаксические ошибки поверх маркеров конфликта.
set -e
cd "$(dirname "$0")"

rm -rf sample-conflict
mkdir sample-conflict
cd sample-conflict

git init -q -b main
git config user.email demo@example.com
git config user.name Demo

cat > greeting.txt <<'EOF'
Guest greeting
==============

Hello, dear guest! Table for two is ready.
EOF

git add . && git commit -qm "Add greeting"

git checkout -qb feature
sed -i '' 's/Hello, dear guest!/Welcome back!/' greeting.txt
git commit -qam "Warmer greeting"

git checkout -q main
sed -i '' 's/Hello, dear guest!/Hi there!/' greeting.txt
git commit -qam "Shorter greeting"

git merge feature >/dev/null 2>&1 || true

echo "==> sample-conflict готов: greeting.txt в состоянии конфликта"
