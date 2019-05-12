#!/bin/sh
# Author : Ahmed Rafik Radwan

# make sure an image was given
if [ ! $1 ]
then
    echo "Must specify The image to tile"
    exit 1
fi

# Get image width and height
IMG=$1
IMG_WIDTH=`gm identify -format %w ${IMG}`
IMG_HEIGHT=`gm identify -format %H ${IMG}`

if [ ! $IMG_WIDTH -o ! $IMG_HEIGHT ]
then
    echo "File must be an Image"
    exit 1
fi

if [ ! $2 ]
then
    echo "Must specify at least the tile width"
    exit 1
fi

# calculate tiles parameters ( count, width, height)
case "$2" in
    -c|--count)
        if [ ! $3 ]
        then
            echo "Must specify at least row tiles count"
            exit 1
        fi

        HORIZONTAL_COUNT=$3
        if [ $4 ]
        then
            VERTICAL_COUNT=$4
        else
            VERTICAL_COUNT=$3
        fi

        TILE_WIDTH=`expr $IMG_WIDTH / $HORIZONTAL_COUNT`
        if [ `expr $IMG_WIDTH % $HORIZONTAL_COUNT` != 0 ]
        then
            TILE_WIDTH=`expr $TILE_WIDTH + 1`
        fi

        TILE_HEIGHT=`expr $IMG_HEIGHT / $VERTICAL_COUNT`
        if [ `expr $IMG_HEIGHT % $VERTICAL_COUNT` != 0 ]
        then
            TILE_HEIGHT=`expr $TILE_HEIGHT + 1`
        fi
        ;;
    *)
        TILE_WIDTH=$2

        if [ $3 ]
        then
            TILE_HEIGHT=$3
        else
            TILE_HEIGHT=$2
        fi

        HORIZONTAL_COUNT=`expr $IMG_WIDTH / $TILE_WIDTH`
        if [ `expr $IMG_WIDTH % $TILE_WIDTH` != 0 ]
        then
            HORIZONTAL_COUNT=`expr $HORIZONTAL_COUNT + 1`
        fi

        VERTICAL_COUNT=`expr $IMG_HEIGHT / $TILE_HEIGHT`
        if [ `expr $IMG_HEIGHT % $TILE_HEIGHT` != 0 ]
        then
            VERTICAL_COUNT=`expr $VERTICAL_COUNT + 1`
        fi
        ;;
esac

# 1. ProgressBar function
# 1.1 Input is currentState($1) and totalState($2)
function ProgressBar {
    # Process data
        let _progress=(${1}*100/${2}*100)/100
        let _done=(${_progress}*4)/10
        let _left=40-$_done
    # Build progressbar string lengths
        _fill=$(printf "%${_done}s")
        _empty=$(printf "%${_left}s")

    # Build progressbar strings and print the ProgressBar line
    printf "\rProgress : [${_fill// /\#}${_empty// /-}] ${_progress}%%"
}

TILES_COUNT=`expr $VERTICAL_COUNT \* $HORIZONTAL_COUNT`
TILES_DONE=0

# Create a folder for tiles if not exist
TILES_DIR="$(dirname ${IMG})/$(basename ${IMG})-${TILE_WIDTH}x${TILE_HEIGHT}_tiles"
mkdir -p $TILES_DIR

# Create tiles
INDEX_ROWS=0
while [ $INDEX_ROWS -lt $VERTICAL_COUNT ]
do
    INDEX_COLS=0
    while [ $INDEX_COLS -lt $HORIZONTAL_COUNT ]
    do
        TOP_OFFSET=`expr $INDEX_ROWS \* $TILE_HEIGHT`
        LEFT_OFFSET=`expr $INDEX_COLS \* $TILE_WIDTH`
        `gm convert -crop ${TILE_WIDTH}x${TILE_HEIGHT}+${LEFT_OFFSET}+${TOP_OFFSET} ${IMG} ${TILES_DIR}/tile-${INDEX_ROWS}-${INDEX_COLS}.jpg`

        TILES_DONE=`expr $TILES_DONE + 1`
        ProgressBar $TILES_DONE $TILES_COUNT

        INDEX_COLS=`expr $INDEX_COLS + 1`
    done
    INDEX_ROWS=`expr $INDEX_ROWS + 1`
done
exit 0
