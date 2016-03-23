#!/bin/bash
set -e

# Build parameters.yml
cat << EOF > /pim/app/config/parameters.yml
parameters:
  database_driver: pdo_mysql
  database_host: ${DB_HOST}
  database_port: ${DB_PORT}
  database_name: ${DB_NAME}
  database_user: ${DB_USER}
  database_password: ${DB_PASSWORD}
  locale: en
  secret: ThisTokenIsNotSoSecretChangeIt
EOF

# wait for mysql to be fully available
while ! nc -z mysql 3306; do sleep 3; done

cd /pim
php app/console cache:clear --env=prod
php app/console pim:install --env=prod

chown www-data:www-data /pim -R
source /etc/apache2/envvars
exec apache2 -D FOREGROUND
