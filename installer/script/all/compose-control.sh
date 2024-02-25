#!/bin/bash

# Author: Mathew Keeling
# 
# Date: 12 February 2024


if [ "$#" -eq 0 ] || [ "$1" = "help" ]; then
  echo "Usage: $0 {start|stop|down|build|destroy|restart}"
  echo "start: Start containers in the background"
  echo "stop: Stop containers"
  echo "down: Stop and remove containers"
  echo "build: Build images"
  echo "destroy: Stop and remove containers, volumes, and images"
  echo "restart: Restart containers"
  exit 0
fi

cd ..

case "$1" in
  start)
    docker-compose up -d
    ;;
  stop)
    docker-compose stop
    ;;
  down)
    docker-compose down
    ;;
  build)
    docker-compose build
    ;;
  destroy)
    docker-compose down --volumes --rmi all
    ;;
  restart)
    docker-compose restart
    ;;
  *)
    echo "Invalid argument. Usage: $0 {start|stop|down|build|destroy|restart}"
    exit 1
esac

exit 0
