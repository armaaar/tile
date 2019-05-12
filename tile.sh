#!/bin/sh

if [ ! $1 ]
then
    echo "Must specify The image to tile"
    exit 1
fi

IMG=$1
IMG_WIDTH=`gm identify -format %w ${IMG}`
IMG_HEIGHT=`gm identify -format %H ${IMG}`

if [ ! $2 ]
then
    echo "Must specify at least the tile width"
    exit 1
fi

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
