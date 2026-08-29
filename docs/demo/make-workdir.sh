#!/bin/sh
# Собирает work/ — копию sample/ с собственным git-репозиторием.
# Запись идёт из work: statusline показывает ветку main игрушечного
# проекта, а не рабочую ветку lazyvimx.
set -e
cd "$(dirname "$0")"

rm -rf work
cp -R sample work

# Прошлая запись оставляет в shada позицию курсора, и LazyVim
# восстанавливает её при открытии файла — каждый тейп должен
# начинаться с 1:1, а не там, где закончился предыдущий.
rm -f profile/state/nvim/shada/*
cd work

git init -q -b main
git config user.email demo@example.com
git config user.name Demo
git add . && git commit -qm "Init"

echo "==> work готов"
