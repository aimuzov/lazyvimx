#!/bin/sh
# Шлёт клавиши в записываемый nvim через сокет: комбинации вроде <C-.>
# и <C-A-l> терминал VHS не передаёт, а remote-send — передаёт, и
# showkeys показывает их честно.
#
#   sh drive.sh <строка> задержка клавиши [задержка клавиши ...]
#
# Стартовый сигнал — курсор на заданной строке: тейп ставит его туда
# последним движением перед включением камеры. Ждать кеймапы нельзя —
# lazy.nvim отдаёт заглушки мгновенно, ещё до готовности nvim.
SOCK=/tmp/vhs-demo.sock
NV="nvim --server $SOCK"

for _ in $(seq 1 240); do
	if [ -S "$SOCK" ]; then
		cur=$($NV --remote-expr "line(\".\")" 2>/dev/null || true)
		[ "$cur" = "$1" ] && break
	fi
	sleep 0.5
done
shift

while [ $# -gt 1 ]; do
	sleep "$1"
	$NV --remote-send "$2"
	shift 2
done
