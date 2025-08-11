#!/bin/bash
set -e

INPUT_URL="https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4"
OUTPUT_FILE="output.mp4"
TEMP_FILE="input.mp4"

echo "📥 تحميل الفيديو من: $INPUT_URL"
if ! curl -fsSL "$INPUT_URL" -o "$TEMP_FILE"; then
    echo "❌ فشل تحميل الفيديو."
    exit 1
fi

echo "🎬 إضافة مربع أسود على الفيديو..."
# نحتاج إعادة ترميز الفيديو عند استخدام drawbox لكن نحافظ على الجودة
if ! ffmpeg -hide_banner -y \
    -i "$TEMP_FILE" \
    -vf "drawbox=x=0:y=0:w=100:h=100:color=black@1.0:t=fill" \
    -c:a copy \
    -crf 18 \
    -preset veryfast \
    "$OUTPUT_FILE"; then
    echo "❌ فشل تعديل الفيديو."
    exit 1
fi

echo "☁ رفع الفيديو المعدل..."
UPLOAD_URL=$(curl -s --upload-file "./$OUTPUT_FILE" "https://transfer.sh/$OUTPUT_FILE")

if [[ -z "$UPLOAD_URL" ]]; then
    echo "❌ فشل رفع الفيديو."
    exit 1
fi

echo "✅ رابط الفيديو المعدل:"
echo "$UPLOAD_URL"
