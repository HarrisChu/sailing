BASE_IMAGE=harrischu/sailing
BASE_IMAGE_TAG=v0.1.0

all: build

build:
	docker build -t ${BASE_IMAGE}:${BASE_IMAGE_TAG} .


debug:
	docker run -it --rm -v `pwd`/inventory:/sailing/inventory   \
		${BASE_IMAGE}:${BASE_IMAGE_TAG}                         \
		pipenv run ansible-playbook -i inventory -e @env debug.yaml -f 10


run:
	docker run -it --rm -v `pwd`/inventory:/sailing/inventory   \
		${BASE_IMAGE}:${BASE_IMAGE_TAG}                         \
		pipenv run ansible-playbook -i inventory -e @env site.yaml -f 10

push:
	docker push ${BASE_IMAGE}:${BASE_IMAGE_TAG}

.PHONY: all build
