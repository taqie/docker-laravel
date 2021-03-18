#!/bin/bash

/etc/init.d/ssh start && /etc/init.d/cron start && /etc/init.d/php8.0-fpm start && /usr/bin/supervisord -c /etc/supervisor/supervisord.conf && nginx -g "daemon off;"
