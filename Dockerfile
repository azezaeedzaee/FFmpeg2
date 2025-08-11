FROM jrottenberg/ffmpeg:4.4-alpine

RUN apk add --no-cache bash curl dos2unix

COPY process-video.sh /app/process-video.sh
WORKDIR /app

RUN dos2unix /app/process-video.sh && chmod +x /app/process-video.sh

ENTRYPOINT []
CMD ["bash", "/app/process-video.sh"]
