#!/bin/bash
set -e  # إيقاف السكربت إذا حدث خطأ

# رابط الفيديو الأصلي
INPUT_URL="https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4"
OUTPUT_FILE="output.mp4"
TEMP_FILE="input.mp4"

echo "📥 جاري تحميل الفيديو من: $INPUT_URL ..."
if ! curl -fsSL "$INPUT_URL" -o "$TEMP_FILE"; then
    echo "❌ فشل تحميل الفيديو. تحقق من الرابط أو الإنترنت."
    exit 1
fi

echo "🎬 جاري تعديل الفيديو عبر FFmpeg..."
if ! ffmpeg -hide_banner -loglevel error -i "$TEMP_FILE" \
    -vf "drawbox=x=0:y=0:w=100:h=100:color=black@0.5:t=max" \
    -c:a copy "$OUTPUT_FILE"; then
    echo "❌ فشل تعديل الفيديو."
    exit 1
fi

echo "☁ جاري رفع الفيديو المعدل..."
UPLOAD_URL=$(curl -s --upload-file "./$OUTPUT_FILE" "https://transfer.sh/$OUTPUT_FILE")

if [[ -z "$UPLOAD_URL" ]]; then
    echo "❌ فشل رفع الفيديو."
    exit 1
fi

echo "✅ رابط الفيديو المعدل:"
echo "$UPLOAD_URL"

# تنظيف الملفات المؤقتة
rm -f "$TEMP_FILE" "$OUTPUT_FILE"
