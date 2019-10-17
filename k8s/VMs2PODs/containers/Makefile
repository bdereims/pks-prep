REGISTRY=$(shell  . ../env ; echo $${FQDN}/$${LIBRARY})
NAMESPACE=$(shell  . ../env ; echo $${NAMESPACE})

CONTAINER_NGINX=nginx
IMAGE_NGINX=$(REGISTRY)/${CONTAINER_NGINX}
STARTUP_SCRIPT=startup.sh

CONTAINER_PHP=php-fpm
IMAGE_PHP=$(REGISTRY)/${CONTAINER_PHP}

all: build-nginx build-php-fpm

build-nginx: nginx/Dockerfile
	sed -e "s/###NAMESPACE###/${USER}/" $(CONTAINER_NGINX)/$(STARTUP_SCRIPT)-template  > $(CONTAINER_NGINX)/$(STARTUP_SCRIPT)
	docker build --build-arg WEBPATH=${NAMESPACE} -f $(CONTAINER_NGINX)/Dockerfile -t $(IMAGE_NGINX):latest .

build-php-fpm: php-fpm/Dockerfile
	docker build --build-arg WEBPATH=${NAMESPACE} -f $(CONTAINER_PHP)/Dockerfile -t $(IMAGE_PHP):latest .

build-all: build-nginx build-php-fpm

push-nginx:
	docker push $(IMAGE_NGINX):latest

push-php-fpm:
	docker push $(IMAGE_PHP):latest

push-all: push-nginx push-php-fpm

clean: 
	docker rmi $(IMAGE_NGINX) $(IMAGE_PHP)
	docker images

clean-all:
	docker images -q | xargs docker rmi
