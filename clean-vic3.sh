#!/bin/sh

cd vic3 || exit

# Remove unneeded folders
rm -r game/gfx/particles
rm -r game/content_source
rm -r binaries
rm -r launcher
rm -r platform_specific_game_data

# Remove unneeded files
rm game/map_data/adjacencies.csv
rm game/map_data/default.map
rm game/map_data/heightmap.heightmap
rm game/map_data/heightmap.png
rm game/map_data/indirection_heightmap.png
rm game/map_data/nodes.dat
rm game/map_data/packed_heightmap.png
rm game/map_data/provinces.png
rm game/map_data/provinces.xcf

# Zero out files
find . -type f -wholename "*/gfx/*.png" -exec truncate -s0 {} +
find . -type f -wholename "*/gfx/*.dds" -exec truncate -s0 {} +
find . -type f -wholename "*/gfx/*.bk2" -exec truncate -s0 {} +
find . -type f -wholename "*/gfx/*.tga" -exec truncate -s0 {} +
find . -type f -wholename "*/gfx/*.bmp" -exec truncate -s0 {} +
find . -type f -wholename "*/gfx/*.mesh" -exec truncate -s0 {} +
find . -type f -wholename "*/fonts/*.ttf" -exec truncate -s0 {} +
find . -type f -wholename "*/fonts/*.otf" -exec truncate -s0 {} +
find . -type f -wholename "*/fonts/*.md" -exec truncate -s0 {} +
find . -type f -wholename "*.bank" -exec truncate -s0 {} +
find . -type f -wholename "*.flac" -exec truncate -s0 {} +
find . -type f -wholename "*.mp3" -exec truncate -s0 {} +