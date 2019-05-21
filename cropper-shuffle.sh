#!/bin/sh

POKEMON_NAME="$(shuf -n 1 $1)"

POKEMON_ATK1="$(shuf -n 1 $2)"
POKEMON_ATK1_TYPE=$(shuf -i 1-11 -n 1)
POKEMON_RANDOM_POW1=$(shuf -i 1-20 -n 1)
POKEMON_POW1=$(echo $(( 10 * $POKEMON_RANDOM_POW1 )))
POKEMON_ATK1_DESC="$(shuf -n 1 $3)"

POKEMON_ATK2="$(shuf -n 1 $2)"
POKEMON_ATK2_TYPE=$(shuf -i 1-11 -n 1)
POKEMON_RANDOM_POW2=$(shuf -i 1-20 -n 1)
POKEMON_POW2=$(echo $(( 10 * $POKEMON_RANDOM_POW2 )))
POKEMON_ATK2_DESC="$(shuf -n 1 $3)"

CARD_TYPE=$(shuf -i 1-11 -n 1)

# Trim 
convert $4 -trim $4

# Crop
convert $4 -resize 390x291^ -gravity Center -extent 390x291 -crop 390x291+25+0 $4

# Overlay Pokemon Image
convert img/templates/$CARD_TYPE.png $4 -geometry +35+55 \
    -compose DstOver -composite \
    $4

# Pokemon Name Insert
convert $4 -font Ubuntu-Medium -pointsize 17 -gravity North -background none -splice 0x32 \
    -annotate -45+60 "$POKEMON_NAME" \
    $4

# Pokemon Attack 1 Insert
convert $4 -font Ubuntu-Medium -pointsize 20 -gravity South -background none -splice 0x32 \
    -annotate -20+270 "$POKEMON_ATK1" \
    -annotate +140+270 "$POKEMON_POW1" \
    $4

# Pokemon Attack 1 Desc
convert $4 -font Ubuntu-Mono-Italic -pointsize 14 -gravity South -background none \
    -annotate +0+240 "$POKEMON_ATK1_DESC" \
    $4

# Overlay Attack 1 Symbol
convert $4 img/templates/s$POKEMON_ATK1_TYPE.png -background none -alpha set -gravity South \
    -geometry -140+265 -define -compose -composite \
    $4

# Pokemon Attack 2 Insert
convert $4 -font Ubuntu-Medium -pointsize 20 -gravity South -background none -splice 0x32 \
    -annotate -20+220 "$POKEMON_ATK2" \
    -annotate +140+220 "$POKEMON_POW2" \
    $4

# Pokemon Attack 2 Desc
convert $4 -font Ubuntu-Mono-Italic -pointsize 14 -gravity South -background none \
    -annotate +0+190 "$POKEMON_ATK2_DESC" \
    $4

# Overlay Attack 1 Symbol
convert $4 img/templates/s$POKEMON_ATK2_TYPE.png -background none -alpha set -gravity South \
    -geometry -140+215 -define -compose -composite \
    $4