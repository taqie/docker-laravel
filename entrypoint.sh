#!/bin/bash

set -e

php artisan migrate --force && php artisan config:cache && php artisan route:cache && php artisan view:cache && /etc/init.d/ssh start && /etc/init.d/cron start && /etc/init.d/php8.0-fpm start && /usr/bin/supervisord -c /etc/supervisor/supervisord.conf && php artisan octane:start --port=8000 --host=0.0.0.0 && nginx -g "daemon off;"
#php artisan migrate --force && php artisan config:cache && php artisan route:cache && php artisan view:cache && /etc/init.d/ssh start && /etc/init.d/cron start && /etc/init.d/php8.0-fpm start && /usr/bin/supervisord -c /etc/supervisor/supervisord.conf && nginx -g "daemon off;"
#nginx -g "daemon off;"

exec "$@"
