#!/bin/sh
# Записывает демо: все тейпы подряд или только названные. Каждый тейп
# отдаёт гифку в gifs/ (её показывает GitHub) и mp4 в videos/ — этим
# живёт сайт, там гифка весила бы вдвое больше.
#
#   cd docs/demo && sh record.sh                  # все
#   cd docs/demo && sh record.sh ui-symbol-usage  # выборочно
set -e
cd "$(dirname "$0")"
mkdir -p gifs videos
sh make-workdir.sh

python3 make-light-tapes.py >/dev/null
python3 make-before-tapes.py >/dev/null

# Первый аргумент light либо before переключает набор тейпов.
DIR=tapes
if [ "$1" = "light" ]; then
	DIR=tapes-light
	shift
elif [ "$1" = "before" ]; then
	DIR=tapes-before
	shift
fi

# vhs изредка теряет ttyd посреди записи. На полном прогоне это стоит
# полутора часов, поэтому пробуем второй раз, а упавшие называем в конце.
record() {
	echo "==> $1"
	vhs "$1" || vhs "$1" || FAILED="$FAILED $1"
}

set +e
if [ $# -gt 0 ]; then
	for name in "$@"; do
		record "$DIR/$name.tape"
	done
else
	for tape in $DIR/*.tape; do
		record "$tape"
	done
fi
set -e

# Hero открывает лендинг: пока грузится сам ролик, место держит первый
# кадр — без него самым тяжёлым элементом первого экрана будет видео.
for hero in videos/hero.mp4 videos/hero-light.mp4; do
	[ -f "$hero" ] || continue
	poster="${hero%.mp4}-poster.webp"
	ffmpeg -v error -y -i "$hero" -frames:v 1 -f image2 -c:v png "$poster.png"
	magick "$poster.png" -quality 80 "$poster"
	rm "$poster.png"
done

ls -lh gifs/ videos/

if [ -n "$FAILED" ]; then
	echo "не записались:$FAILED"
	exit 1
fi
