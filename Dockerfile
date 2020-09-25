FROM tiredofit/nginx-php-fpm:7.2
LABEL maintainer="Dave Conroy (dave at tiredofit dot ca)"

### Set Defaults
ENV CACHET_VERSION=2.4 \
    CACHET_REPO_URL=https://github.com/CachetHQ/Cachet \
    NGINX_WEBROOT=/www/html \
    PHP_ENABLE_CREATE_SAMPLE_PHP=FALSE \
    PHP_ENABLE_CURL=TRUE \
    PHP_ENABLE_FILEINFO=TRUE \
    PHP_ENABLE_IMAP=TRUE \
    PHP_ENABLE_LDAP=TRUE \
    PHP_ENABLE_MCRYPT=TRUE \
    PHP_ENABLE_MBSTRING=TRUE \
    PHP_ENABLE_OPENSSL=TRUE \
    PHP_ENABLE_SIMPLEXML=TRUE \
    PHP_ENABLE_TOKENIZER=TRUE \
    PHP_ENABLE_ZIP=TRUE \
    ZABBIX_HOSTNAME=cachet-app

### Perform Installation
RUN set -x && \
    apk update && \
    apk upgrade && \
    apk add -t .cachet-build-deps \
              nodejs \
              nodejs-npm \
              #bower \
              #gulp \
              && \
    apk add -t .cachet-run-deps \
              expect \
              git \
              #gnu-libiconv \
              sed \
	      && \
    \
### WWW  Installation
    mkdir -p /assets/install && \
    git clone ${CACHET_REPO_URL} /assets/install && \
    cd /assets/install && \
    git checkout ${CACHET_VERSION} && \
    rm -rf \
        /assets/install/.env.example \
        /assets/install/.env.travis \
        && \
    \
    composer install --no-dev -o && \
    chown -R nginx:www-data /assets/install && \
    \
### Cleanup
    rm -rf /root/.config /root/.composer && \
    rm -rf /var/tmp/* /var/cache/apk/*

### Assets
ADD install /
