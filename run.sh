#!/bin/bash


cd wordpress/

cd mysql/

docker build -t wordpress/mysql .

cd ../downloader

docker build -t wordpress/downloader .

cd ../php-fpm

docker build -t wordpress/php-fpm .

cd ../nginx

docker build -t wordpress/nginx .


docker run -d --name mysql wordpress/mysql
docker run -i -t --name downloader wordpress/downloader

docker run --name app1 --volumes-from downloader --link mysql:db wordpress/php-fpm
docker run -d  --name app2 --volumes-from downloader --link mysql:db wordpress/php-fpm
docker run -d -p 80:80 --name nginx --volumes-from downloader --link app1:app1 --link app2:app2 wordpress/nginx



