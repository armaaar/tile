#!/bin/sh

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
        TILE_HEIGHT=`expr $IMG_HEIGHT / $VERTICAL_COUNT`
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
        VERTICAL_COUNT=`expr $IMG_HEIGHT / $TILE_HEIGHT`
        ;;
esac

