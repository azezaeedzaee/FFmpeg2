#!/bin/bash

# هنا يفترض أنك ستستلم الفيديو من n8n (مثلاً عبر curl)
# مؤقتاً سنفترض أن الفيديو موجود باسم input.mp4
# وتريد تعديله وإخراجه باسم output.mp4

ffmpeg -i input.mp4 \
  -vf "drawbox=x=0:y=0:w=iw:h=100:color=black:t=fill" \
  -c:a copy output.mp4

echo "✅ تم تعديل الفيديو وحفظه باسم output.mp4"
