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
j2 /deploy/templates/config.php > common/config/config.php
j2 /deploy/templates/portalConfig.coffee > static/portal/coffee/config.coffee
j2 /deploy/templates/chatConfig.coffee > static/chat/config.coffee
j2 /src/modules/baomi/deploy/templates/config.php > /src/modules/baomi/backend/config/config.php

echo "run init"
php initStage
echo "generate translations"
node translate.js
echo "generate soft link for external module"
grunt linkmodule
echo "run grunt clean and build"
grunt cbuild
echo "scan modules"
php yii module/scan
echo "add account menus and mods"
php yii management/account/add-menus-and-mods
echo "ensure mongo indexes"
php yii management/index
echo "ensure cron resque job"
php yii management/job/init 1
echo "add the default sensitive operation to all accounts"
php yii management/sensitive-operation/index
echo "run migration"
php yii baomi/migration/perform

echo "Done!"
