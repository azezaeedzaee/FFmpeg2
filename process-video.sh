#!/bin/bash

# تحقق أن رابط الفيديو موجود
if [ -z "$VIDEO_URL" ]; then
  echo "❌ خطأ: لم يتم تمرير متغير VIDEO_URL"
  exit 1
fi

# تحميل الفيديو
echo "⬇️ جاري تحميل الفيديو من: $VIDEO_URL"
curl -L "$VIDEO_URL" -o input.mp4

# تعديل الفيديو
echo "🎬 جاري تعديل الفيديو..."
ffmpeg -i input.mp4 \
  -vf "drawbox=x=0:y=0:w=iw:h=100:color=black:t=fill" \
  -c:a copy output.mp4

# حفظ الناتج
echo "✅ تم تعديل الفيديو وحفظه باسم output.mp4"
ffmpeg -version
