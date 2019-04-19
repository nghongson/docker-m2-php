.SILENT:
## Colors
COLOR_RESET   = \033[0m
COLOR_INFO    = \033[32m
COLOR_COMMENT = \033[33m
IMAGE = leonguyen/magento2-php
distro = stretch
mode = fpm
## Help
help:
	printf "${COLOR_COMMENT}Usage:${COLOR_RESET}\n"
	printf "make [target]\n\n"
	printf "${COLOR_COMMENT}Available targets:${COLOR_RESET}\n"
	awk '/^[a-zA-Z\-\_0-9\.@]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
	if (helpMessage) { \
		helpCommand = substr($$1, 0, index($$1, ":")); \
		helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
		printf " ${COLOR_INFO}%-16s${COLOR_RESET} %s\n", helpCommand, helpMessage; \
	} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

###############
# Environment #
###############
build:
	printf "${COLOR_COMMENT}Build Application Images:${COLOR_RESET}\n"
	docker build -t ${IMAGE}:${version}-${mode}-${distro} --build-arg PHP_MOD=${mode} ${version}/${distro}/${mode}
build70:
	printf "${COLOR_COMMENT}Build Images Magento PHP7.1 Distro Debian :${COLOR_RESET}\n"
	$(MAKE) build version=7.0
	$(MAKE) build version=7.0 mode=fpm
	$(MAKE) build version=7.0 mode=cli
	$(MAKE) build version=7.0 mode=apache
build71:
	printf "${COLOR_COMMENT}Build Images Magento PHP7.1 Distro Debian :${COLOR_RESET}\n"
	$(MAKE) build version=7.1
	$(MAKE) build version=7.1 mode=fpm
	$(MAKE) build version=7.1 mode=cli
	$(MAKE) build version=7.1 mode=apache

build72:
	printf "${COLOR_COMMENT}Build Images Magento PHP7.2 Distro Debian :${COLOR_RESET}\n"
	$(MAKE) build version=7.2
	$(MAKE) build version=7.2 mode=fpm
	$(MAKE) build version=7.2 mode=cli
	$(MAKE) build version=7.2 mode=apache

	printf "${COLOR_COMMENT}Build Images Magento PHP7.2 Distro Alpine :${COLOR_RESET}\n"

build73:
	printf "${COLOR_COMMENT}Build Images Magento PHP7.2 Distro Debian :${COLOR_RESET}\n"
	$(MAKE) build version=7.3
	$(MAKE) build version=7.3 mode=fpm
	$(MAKE) build version=7.3 mode=cli
	$(MAKE) build version=7.3 mode=apache

	printf "${COLOR_COMMENT}Build Images Magento PHP7.2 Distro Alpine :${COLOR_RESET}\n"
	$(MAKE) build version=7.3 mode=cli distro=alpine
	$(MAKE) build version=7.3 mode=fpm distro=alpine

push:
	docker push ${IMAGE}:${tag}
