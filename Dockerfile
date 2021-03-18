FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive
ENV WORKDIR=/var/www/html
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN apt-get update && apt-get install -y git nano htop curl cron ssh nasm ssh build-essential software-properties-common \
    libpng-dev autoconf automake gcc g++ make libtool dpkg pkg-config nginx supervisor mysql-client

RUN add-apt-repository ppa:ondrej/php && apt-get update && \
    curl -fsSL https://deb.nodesource.com/setup_14.x | bash - && apt-get install -y nodejs

RUN apt-get install -y php8.0 php8.0-bcmath php8.0-bz2 php8.0-cli php8.0-common php8.0-curl php8.0-dev php8.0-fpm php8.0-gd \
    php8.0-imap php8.0-intl php8.0-mbstring php8.0-mcrypt php8.0-mysql php8.0-opcache php8.0-redis php8.0-xml php8.0-xsl \
    php8.0-zip php8.0-xsl php8.0-zip && rm -rf /var/lib/apt/lists/* && rm -rf /etc/localtime && ln -s /usr/share/zoneinfo/Europe/Warsaw /etc/localtime && \
    echo "clear_env=no" >> "/etc/php/8.0/fpm/pool.d/www.conf"

EXPOSE 80

COPY entrypoint.sh /

RUN chmod +x /entrypoint.sh

WORKDIR ${WORKDIR}

ENTRYPOINT ["/bin/bash","-c"]
#CMD /etc/init.d/ssh start && /etc/init.d/cron start && /etc/init.d/php8.0-fpm start && /usr/bin/supervisord -c /etc/supervisor/supervisord.conf && nginx -g "daemon off;"
CMD ["/entrypoint.sh"]
#ENTRYPOINT ["/entrypoint.sh"]
