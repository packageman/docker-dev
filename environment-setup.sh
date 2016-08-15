#! /bin/bash

set -e

function install_prerequisites {
	sudo apt-get update
	sudo apt-get install -y wget curl supervisor software-properties-common
}

function install_nvm {
	echo "installing nvm"
	wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.31.4/install.sh | bash
	echo "installed nvm"
}

function configure_node_using_nvm {
	source ~/.nvm/nvm.sh
	if [[ $(nvm list | grep v0.12.2 | wc -l) = 0 ]]; then
		nvm install ${NODE_VERSION}
	fi
	nvm use ${NODE_VERSION}
}

function install_grunt {
	npm install -g grunt-cli --registry=https://registry.npm.taobao.org
}

function install_ruby {
	echo "installing ruby 2.2"
	sudo apt-add-repository -y ppa:brightbox/ruby-ng
	sudo apt-get update
	sudo apt-get install -y ruby2.2
	echo "installed ruby 2.2"
}

function install_sass {
	echo "installing sass"
	gem sources --remove http://rubygems.org/
	gem sources -a https://ruby.taobao.org/
	gem sources -l
	sudo gem install sass
	echo "installed sass"
}

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

function install_php {
	echo "installing php5.6"
	sudo locale-gen en_US.UTF-8
	export LANG=en_US.UTF-8
	export LC_ALL=en_US.UTF-8
	sudo add-apt-repository -y ppa:ondrej/php5-5.6
	sudo apt-get update
	sudo apt-get install -y php5-cgi \
        php5-fpm \
        php5-curl \
        php5-mcrypt \
        php5-gd \
        php5-dev \
        php5-redis \
        php5-mongo \
        php5-xdebug
	echo "installed php5.6"
}

export NODE_VERSION=v0.12.2

install_prerequisites

if [[ ! -s ~/.nvm/nvm.sh ]]; then
	install_nvm
fi

configure_node_using_nvm

if [[ ! $(which grunt) ]]; then
	install_grunt
fi

if [[ ! $(which ruby) ]]; then
	install_ruby
fi

if [[ ! $(which sass) ]]; then
	install_sass
fi

if [[ ! $(which docker) ]]; then
	install_docker
	add_current_user_into_docker_group
fi

if [[ ! $(which docker-compose) ]]; then
	install_docker_compose
fi

if [[ ! $(which php) ]]; then
	install_php
fi

cd ../src

if [[ ! -d modules/baomi/.git ]]; then
  if [[ -d modules/baomi ]]; then
    rm modules/baomi/ -rf
  fi
  git clone git@git.augmentum.com.cn:BaoMi/Server.git modules/baomi
fi

./initStage
npm install --registry=https://registry.npm.taobao.org

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
docker-compose up -d

cd ../src
grunt cbuild
