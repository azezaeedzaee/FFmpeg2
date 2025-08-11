#!/bin/bash
set -e

INPUT_URL="https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4"
OUTPUT_FILE="output.mp4"

echo "📥 تحميل الفيديو من: $INPUT_URL"
curl -L "$INPUT_URL" -o input.mp4

echo "🎬 تعديل الفيديو عبر FFmpeg..."
ffmpeg -i input.mp4 -vf "drawbox=x=0:y=0:w=100:h=100:color=black@0.5:t=fill" -c:a copy "$OUTPUT_FILE"

echo "☁ رفع الفيديو المعدل..."
UPLOAD_URL=$(curl --upload-file "./$OUTPUT_FILE" https://transfer.sh/$OUTPUT_FILE)

echo "✅ رابط الفيديو المعدل:"
echo "$UPLOAD_URL"
