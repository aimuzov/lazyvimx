#!/bin/sh
# Записывает гифки: все тейпы подряд или только названные.
#
#   cd docs/demo && sh record.sh                  # все
#   cd docs/demo && sh record.sh ui-symbol-usage  # выборочно
set -e
cd "$(dirname "$0")"
mkdir -p gifs
sh make-workdir.sh

python3 make-light-tapes.py >/dev/null

# Первый аргумент light переключает на набор светлых тейпов.
DIR=tapes
if [ "$1" = "light" ]; then
	DIR=tapes-light
	shift
fi

if [ $# -gt 0 ]; then
	for name in "$@"; do
		echo "==> $DIR/$name"
		vhs "$DIR/$name.tape"
	done
else
	for tape in $DIR/*.tape; do
		echo "==> $tape"
		vhs "$tape"
	done
fi

ls -lh gifs/
