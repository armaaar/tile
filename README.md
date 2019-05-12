# Tile: Create tiles for any image
Tile is a shell script to convert any given images to tiles.

## Requirements
- [GraphicsMagick](http://www.graphicsmagick.org/)
- [Git Bash](https://git-scm.com/) (For windows users to run shell scripts)

## How to use
```bash
sh ./tile.sh image_path [ options ... ]
```
- To crop image to square tiles of 100x100 pixels:
```bash
sh tile.sh img.jpg 100
```
- To crop image to tiles of 100x200 pixels:
```bash
sh tile.sh img.jpg 100 200
```
- To crop image to 5 x 5 tiles
```bash
sh tile.sh img.jpg -c 5
# or
sh tile.sh img.jpg --count 5
```
- To crop image to 5 x 10 tiles
```bash
sh tile.sh img.jpg -c 5 10
# or
sh tile.sh img.jpg --count 5 10
```


## Credits
Progress bar credits go to [Teddy Skarin](https://github.com/fearside) for his [ProgressBar](https://github.com/fearside/ProgressBar) repository

## License
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
