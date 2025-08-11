# نبدأ من صورة خفيفة تحتوي FFmpeg
FROM jrottenberg/ffmpeg:4.4-alpine

# تثبيت curl و bash (اختياري)
RUN apk add --no-cache bash curl

# نسخ السكربت الذي سيشغل FFmpeg
COPY process-video.sh /app/process-video.sh
WORKDIR /app

# جعل السكربت قابل للتنفيذ
RUN chmod +x /app/process-video.sh

# عند التشغيل، نفذ السكربت
CMD ["/app/process-video.sh"]
