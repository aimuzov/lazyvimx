#!/bin/sh
# Прогрев demo-профиля перед записью гифок: ставит плагины, LSP и
# treesitter-парсеры в изолированный профиль, чтобы первый кадр записи
# не превращался в установку.
#
#   cd docs/demo && sh warmup.sh
#
# Кэш живёт в profile/{data,state,cache} (в gitignore) — платит только первый запуск.
set -e
cd "$(dirname "$0")"

export XDG_CONFIG_HOME="$PWD/profile/config"
export XDG_DATA_HOME="$PWD/profile/data"
export XDG_STATE_HOME="$PWD/profile/state"
export XDG_CACHE_HOME="$PWD/profile/cache"

# Две фазы: пока LazyVim не скачан, cond-проверки некоторых экстр
# падают на глобале LazyVim — поэтому сначала база, потом все экстры.
echo "==> lazy.nvim: установка базы (LazyVim и плагины оверрайдов)"
DEMO_EXTRAS="" nvim --headless "+Lazy! sync" +qa

# Все экстры сразу: профиль один на все тейпы, различается
# только DEMO_EXTRAS на запуске.
export DEMO_EXTRAS="core.extras,core.colorschemes"

echo "==> lazy.nvim: установка плагинов экстр"
nvim --headless "+Lazy! sync" +qa

echo "==> mason: lua-language-server (в headless ставится синхронно)"
nvim --headless -c "MasonInstall lua-language-server" -c "quitall" || true

echo "==> treesitter и остальное асинхронное: открываем файлы и ждём"
nvim --headless \
	-c "edit sample/app.lua" \
	-c "sleep 45" \
	-c "quitall!" || true

echo "==> готово"
