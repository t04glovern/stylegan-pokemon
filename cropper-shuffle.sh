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
convert $4 -trim img/pokemon.png

# Crop
convert img/pokemon.png -resize 390x291^ -gravity Center -extent 390x291 -crop 390x291+25+0 img/pokemon.png

# Overlay Pokemon Image
convert img/templates/$CARD_TYPE.png img/pokemon.png -geometry +35+55 \
    -compose DstOver -composite \
    img/pokemon.png

# Pokemon Name Insert
convert img/pokemon.png -font Ubuntu-Medium -pointsize 17 -gravity North -background none -splice 0x32 \
    -annotate -45+60 "$POKEMON_NAME" \
    img/pokemon.png

# Pokemon Attack 1 Insert
convert img/pokemon.png -font Ubuntu-Medium -pointsize 20 -gravity South -background none -splice 0x32 \
    -annotate -20+270 "$POKEMON_ATK1" \
    -annotate +140+270 "$POKEMON_POW1" \
    img/pokemon.png

# Pokemon Attack 1 Desc
convert img/pokemon.png -font Ubuntu-Mono-Italic -pointsize 14 -gravity South -background none \
    -annotate +0+240 "$POKEMON_ATK1_DESC" \
    img/pokemon.png

# Overlay Attack 1 Symbol
convert img/pokemon.png img/templates/s$POKEMON_ATK1_TYPE.png -background none -alpha set -gravity South \
    -geometry -140+265 -define -compose -composite \
    img/pokemon.png

# Pokemon Attack 2 Insert
convert img/pokemon.png -font Ubuntu-Medium -pointsize 20 -gravity South -background none -splice 0x32 \
    -annotate -20+220 "$POKEMON_ATK2" \
    -annotate +140+220 "$POKEMON_POW2" \
    img/pokemon.png

# Pokemon Attack 2 Desc
convert img/pokemon.png -font Ubuntu-Mono-Italic -pointsize 14 -gravity South -background none \
    -annotate +0+190 "$POKEMON_ATK2_DESC" \
    img/pokemon.png

# Overlay Attack 1 Symbol
convert img/pokemon.png img/templates/s$POKEMON_ATK2_TYPE.png -background none -alpha set -gravity South \
    -geometry -140+215 -define -compose -composite \
    img/pokemon.png