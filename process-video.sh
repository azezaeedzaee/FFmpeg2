#!/bin/bash
set -e

INPUT_URL="https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4"
OUTPUT_FILE="output.mp4"

curl -sL "$INPUT_URL" -o input.mp4

ffmpeg -i input.mp4 -vf "drawbox=x=0:y=0:w=100:h=100:color=black@1.0:t=max" \
  -c:v libx264 -crf 18 -preset veryfast -c:a copy "$OUTPUT_FILE" -y -loglevel error

curl -s --upload-file "./$OUTPUT_FILE" https://transfer.sh/$OUTPUT_FILE
