# نبدأ من صورة خفيفة تحتوي FFmpeg
FROM jrottenberg/ffmpeg:4.4-alpine

# تثبيت curl و bash
RUN apk add --no-cache bash curl

# نسخ السكربت
COPY process-video.sh /app/process-video.sh
WORKDIR /app

# جعل السكربت قابل للتنفيذ
RUN chmod +x /app/process-video.sh

# إلغاء الـ ENTRYPOINT الافتراضي لـ ffmpeg
ENTRYPOINT []

# تشغيل السكربت باستخدام bash
CMD ["bash", "/app/process-video.sh"]
