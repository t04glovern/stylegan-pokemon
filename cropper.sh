#!/bin/sh

POKEMON_NAME="$1"

POKEMON_ATK1="$2"
POKEMON_ATK1_TYPE=$(shuf -i 1-11 -n 1)
POKEMON_RANDOM_POW1=$(shuf -i 1-20 -n 1)
POKEMON_POW1=$(echo $(( 10 * $POKEMON_RANDOM_POW1 )))
POKEMON_ATK1_DESC="$3"

POKEMON_ATK2="$4"
POKEMON_ATK2_TYPE=$(shuf -i 1-11 -n 1)
POKEMON_RANDOM_POW2=$(shuf -i 1-20 -n 1)
POKEMON_POW2=$(echo $(( 10 * $POKEMON_RANDOM_POW2 )))
POKEMON_ATK2_DESC="$5"

CARD_TYPE=$(shuf -i 1-11 -n 1)

# Trim 
convert $6 -trim $6

# Crop
convert $6 -resize 390x291^ -gravity Center -extent 390x291 -crop 390x291+25+0 $6

# Overlay Pokemon Image
convert img/templates/$CARD_TYPE.png $6 -geometry +35+55 \
    -compose DstOver -composite \
    $6

# Pokemon Name Insert
convert $6 -font Ubuntu-Medium -pointsize 17 -gravity North -background none -splice 0x32 \
    -annotate -45+60 "$POKEMON_NAME" \
    $6

# Pokemon Attack 1 Insert
convert $6 -font Ubuntu-Medium -pointsize 20 -gravity South -background none -splice 0x32 \
    -annotate -20+270 "$POKEMON_ATK1" \
    -annotate +140+270 "$POKEMON_POW1" \
    $6

# Pokemon Attack 1 Desc
convert $6 -font Ubuntu-Mono-Italic -pointsize 14 -gravity South -background none \
    -annotate +0+240 "$POKEMON_ATK1_DESC" \
    $6

# Overlay Attack 1 Symbol
convert $6 img/templates/s$POKEMON_ATK1_TYPE.png -background none -alpha set -gravity South \
    -geometry -140+265 -define -compose -composite \
    $6

# Pokemon Attack 2 Insert
convert $6 -font Ubuntu-Medium -pointsize 20 -gravity South -background none -splice 0x32 \
    -annotate -20+220 "$POKEMON_ATK2" \
    -annotate +140+220 "$POKEMON_POW2" \
    $6

# Pokemon Attack 2 Desc
convert $6 -font Ubuntu-Mono-Italic -pointsize 14 -gravity South -background none \
    -annotate +0+190 "$POKEMON_ATK2_DESC" \
    $6

# Overlay Attack 1 Symbol
convert $6 img/templates/s$POKEMON_ATK2_TYPE.png -background none -alpha set -gravity South \
    -geometry -140+215 -define -compose -composite \
    $6