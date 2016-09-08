#! /bin/bash

set -e

function install_docker {
	echo "installing docker"
	sudo /bin/bash -c "curl -sSL https://get.daocloud.io/docker | sh"
	sudo /bin/bash -c "curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://54d58250.m.daocloud.io"
	sudo sed -i 's/DOCKER_OPTS="\(.*\)"/DOCKER_OPTS="\1 --dns 114.114.114.114"/g' /etc/default/docker
	sudo service docker restart
	echo "installed docker"
}

function add_current_user_into_docker_group {
	echo "adding user $USER into docker group"
	sudo usermod -aG docker $USER
	echo "added user $USER into docker group"
}

function install_docker_compose {
	echo "installing docker-compose"
	curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > docker-compose
	chmod +x docker-compose
	sudo mv docker-compose /usr/local/bin
	echo "installed docker-compose"
}

if [[ ! $(which docker) ]]; then
	install_docker
	add_current_user_into_docker_group
fi

if [[ ! $(which docker-compose) ]]; then
	install_docker_compose
fi

cd ../src

if [[ ! -d modules/baomi/.git ]]; then
  if [[ -d modules/baomi ]]; then
    rm modules/baomi/ -rf
  fi
  git clone git@git.augmentum.com.cn:BaoMi/Server.git modules/baomi
fi

sudo /bin/bash -c "echo 127.0.0.1 localadmin.baomiding.com >> /etc/hosts"
sudo /bin/bash -c "echo 127.0.0.1 localapi.baomiding.com >> /etc/hosts"
sudo /bin/bash -c "echo 127.0.0.1 php >> /etc/hosts"
sudo /bin/bash -c "echo 127.0.0.1 mongodb >> /etc/hosts"
sudo /bin/bash -c "echo 127.0.0.1 redis >> /etc/hosts"

# link modules
ln -sf ../../modules/baomi/backend backend/modules/baomi
ln -sf ../../modules/baomi/console console/modules/baomi
ln -sf ../../../modules/baomi/static static/portal/modules/baomi

# config git hooks
ln -sf ../../pre-commit modules/baomi/.git/hooks/pre-commit
ln -sf ../../validate-commit-msg modules/baomi/.git/hooks/commit-msg

cd ../docker
sudo docker-compose up -d

sudo docker exec $(sudo docker ps | grep php-supervisor-node-sass | awk '{print $1}') /bin/bash -c "cd /src \
  && ./initStage \
  && npm install --registry=https://registry.npm.taobao.org \
  && grunt cbuild \
  && ./yii baomi/data/populate dev"

cd ../src
# update permission of logs directory
sudo chmod -R 777 backend/runtime/logs
sudo chmod -R 777 frontend/runtime/logs
sudo chmod -R 777 console/runtime/logs
