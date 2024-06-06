#!/bin/sh

ssh root@52.22.107.229 <<EOF
  cd /var/www/my-project
  git pull
  docker-compose -f docker-compose.prod.yml up --build -d
  exit
EOF
