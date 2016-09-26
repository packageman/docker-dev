#! /bin/bash

set -e
exec 2>&1

pidFile=/tmp/mongod.pid
configFile=/etc/mongod.conf
userInitializedFile=/tmp/mongoUserInitialized

function init_mongo_user {
  /sbin/setuser mongodb mongod -f $configFile --noauth --pidfilepath $pidFile --fork

  while [[ -z $(netstat -luntp | grep 27017) ]]
  do
    echo "sleep 1 seconds"
    sleep 1
  done

  username=${MONGO_USERNAME:-"admin"}
  password=${MONGO_PASSWORD:-"Abc123__"}

  echo "db.createUser({user: '${username}', pwd: '${password}', roles: ['root']})" | mongo admin
  echo "username: $username, password: $password, role: root" > $userInitializedFile

  kill -2 `cat $pidFile`
  rm $pidFile
}

if [[ $INIT_MONGO_USER ]] && [[ ! -f $userInitializedFile ]]; then
  init_mongo_user
fi

/sbin/setuser mongodb mongod -f $configFile
