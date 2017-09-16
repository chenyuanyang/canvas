#!/bin/bash

#项目名称
deploy_project_name=${DEPLOY_PROJECT_NAME:=blog}

#配置文件替换目录
reconf_path=${RECONF_PATH:=/var/work/reconf}

#本地项目目录
srcdir=`pwd`

#build目录
buildpath=$srcdir

#项目日志目录
log_path=/var/data/log/$deploy_project_name

#php项目持久存储目录
storage_path=${STORAGE_PATH:=/var/work/storage}

#host
#db_host=${DB_HOST:=""}

########## 本地打包处理 ##########
#composer更新
composer install -vvv --no-dev --ignore-platform-reqs --no-interaction --optimize-autoloader --no-scripts

#替换环境变量

cp $buildpath/.env.example $buildpath/.env
sed -i "s|\[\[\[APP_LOG_PATH\]\]\]|${log_path}|g" $buildpath/.env
sed -i "s|\[\[\[DB_HOST\]\]\]|${DB_HOST}|g" $buildpath/.env
sed -i "s|\[\[\[DB_DATABASE\]\]\]|${DB_DATABASE}|g" $buildpath/.env
sed -i "s|\[\[\[DB_USERNAME\]\]\]|${DB_USERNAME}|g" $buildpath/.env
sed -i "s|\[\[\[DB_PASSWORD\]\]\]|${DB_PASSWORD}|g" $buildpath/.env


#sed -i 's/\[\[\[DEPLOY_ENV_FLAG\]\]\]/'${deploy_env_flag}'/g' $buildpath/.env
#sed -i "s|\[\[\[DB_HOST\]\]\]|${db_host}|g" $buildpath/.env
#sed -i "s|\[\[\[DB_HOST_REDIS\]\]\]|${redis_host}|g" $buildpath/.env

#清理目录
#find $buildpath -name '.DS_Store' | xargs rm -rf
#find $buildpath -name '.gitignore' | xargs rm -rf

#修改权限
#chmod -R 775 $buildpath

# php-fpm.sh reload
service php7.0-fpm restart



