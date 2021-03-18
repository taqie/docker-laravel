#!/bin/bash

set -e

php artisan migrate && php artisan config:cache && php artisan route:cache && php artisan view:cache && /etc/init.d/ssh start && /etc/init.d/cron start && /etc/init.d/php8.0-fpm start && /usr/bin/supervisord -c /etc/supervisor/supervisord.conf && nginx -g "daemon off;"

exec "$@"
