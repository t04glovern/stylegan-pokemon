#!/bin/sh

POKEMON_NAME="$1"

convert img/pokemon.png -resize 140x100^ -gravity center -extent 140x100 -crop 140x100+0+0 img/pokemon.png
convert img/template.png img/pokemon.png -geometry +27+34 -compose DstOver -composite img/pokemon.png
convert img/pokemon.png -pointsize 12 -gravity North -background none -splice 0x32 -annotate -30+47 $POKEMON_NAME img/pokemon.png