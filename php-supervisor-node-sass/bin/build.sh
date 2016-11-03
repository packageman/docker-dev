#! /bin/bash

set -e

cd /src

echo "install dependency"
npm install --registry=https://registry.npm.taobao.org

echo "replace gninx templates for env ${CURRENT_ENV}"
containerIp=`ifconfig eth0 | awk '/inet addr/{print substr($2,6)}'`
export PHP_FPM_HOST=${containerIp}

j2 ${NGINX_SITE_ADMIN_CONF_PATH} > /etc/nginx/site-enabled/${NGINX_SITE_ADMIN_NAME}.conf
j2 ${NGINX_SITE_API_CONF_PATH} > /etc/nginx/site-enabled/${NGINX_SITE_API_NAME}.conf

echo "replace config templates for env ${CURRENT_ENV}"

echo "Do something about grunt, migration work"

echo "Done!"
