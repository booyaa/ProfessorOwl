#!/usr/bin/env bash

# convert -delay 4 20150916-*.png temp/%05d.jpg
# ffmpeg -i temp/%05d.jpg -c:v libx264 -vf fps=25 -pix_fmt yuv420p output.mp4
