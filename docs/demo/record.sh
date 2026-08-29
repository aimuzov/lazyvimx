#!/bin/sh
# Записывает гифки: все тейпы подряд или только названные.
#
#   cd docs/demo && sh record.sh                  # все
#   cd docs/demo && sh record.sh ui-symbol-usage  # выборочно
set -e
cd "$(dirname "$0")"
mkdir -p gifs
sh make-workdir.sh

if [ $# -gt 0 ]; then
	for name in "$@"; do
		echo "==> $name"
		vhs "tapes/$name.tape"
	done
else
	for tape in tapes/*.tape; do
		echo "==> $tape"
		vhs "$tape"
	done
fi

ls -lh gifs/
