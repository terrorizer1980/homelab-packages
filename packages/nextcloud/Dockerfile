FROM nextcloud:22.2.3-fpm

RUN apt-get update; \
    apt-get install -y --no-install-recommends \
        ffmpeg \
        libmagickcore-6.q16-6-extra

RUN apk add bzip2-dev
RUN docker-php-ext-install bz2
