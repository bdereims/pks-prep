REGISTRY=harbor.cpod-appstx.az-lab.shwrfr.com/library

CONTAINER_NGINX=nginx
IMAGE_NGINX=$(REGISTRY)/${CONTAINER_NGINX}

CONTAINER_PHP=php-fpm
IMAGE_PHP=$(REGISTRY)/${CONTAINER_PHP}

build-nginx: nginx/Dockerfile
	docker build -f $(CONTAINER_NGINX)/Dockerfile -t $(IMAGE_NGINX) .

build-php-fpm: php-fpm/Dockerfile
	docker build -f $(CONTAINER_PHP)/Dockerfile -t $(IMAGE_PHP) .

clean: 
	docker rmi $(IMAGE_NGINX) $(IMAGE_PHP)
	docker images

