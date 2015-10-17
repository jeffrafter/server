#!/bin/bash

# Try to load in some environment settings
source $(dirname $0)/env.sh

install() {
  echo -e "\e[0;32m$FUNCNAME\e[0m"
  wget https://raw.githubusercontent.com/progrium/dokku/v0.4.2/bootstrap.sh
  DOKKU_TAG=v0.4.2 bash bootstrap.sh
  echo "Please open http://$HOSTNAME to complete the installation [Enter]"
  read enter
}

setup_dokku_ssh() {
  echo -e "\e[0;32m$FUNCNAME\e[0m"
  usermod -a -G ssh-user dokku
  # cp ${HOME}/.ssh/authorized_keys /home/dokku/.ssh/authorized_keys
  # chmod 400 /home/dokku/.ssh/authorized_keys
  # chown dokku:dokku /home/dokku/.ssh/authorized_keys
}

setup_dokku_application() {
  dokku apps:create $APPLICATION
}

setup_dokku_plugins() {
  echo -e "\e[0;32m$FUNCNAME\e[0m"
  mkdir -p /var/log/dokku # For logging-supervisord
  chown dokku:dokku /var/log/dokku

  dokku plugin:install https://github.com/dokku/dokku-postgres.git postgres
  dokku plugin:install https://github.com/dokku/dokku-redis.git redis
  dokku plugin:install https://github.com/sehrope/dokku-logging-supervisord.git
}

setup_firewall() {
  echo -e "\e[0;32m$FUNCNAME\e[0m"
  ufw allow in on docker0 to 172.17.42.1
  ufw reload
}

setup_redis() {
  echo -e "\e[0;32m$FUNCNAME\e[0m"
  dokku redis:create $APPLICATION
  dokku redis:link $APPLICATION $HOSTNAME
}

setup_postgres() {
  echo -e "\e[0;32m$FUNCNAME\e[0m"
  dokku postgres:create $APPLICATION
  dokku postgres:link $APPLICATION $HOSTNAME
}

main() {
  # install
  setup_dokku_ssh
  setup_dokku_application
  setup_dokku_plugins
  setup_firewall
}

main
