repository=vue-tool
user=hatlonely
version=$(shell git describe --tags)

.PHONY: buildenv
buildenv:
	if [ -z "$(shell docker ps --filter name=vue-build-env -q)" ]; then \
		docker run --name vue-build-env -d node:12.10.0-alpine tail -f /dev/null; \
	fi

.PHONY: cleanbuildenv
cleanbuildenv:
	if [ ! -z "$(shell docker ps --filter name=vue-build-env -q)" ]; then \
		docker stop vue-build-env && docker rm vue-build-env; \
	fi

.PHONY: image
image: buildenv
	docker exec -i vue-build-env rm -rf /data/src/hpifu/${repository}
	docker exec -i vue-build-env mkdir -p /data/src/hpifu/${repository}
	docker cp . vue-build-env:/data/src/hpifu/${repository}
	docker exec -i vue-build-env sh -c "cd /data/src/hpifu/${repository} && npm install && npm run build"
	mkdir -p docker/
	docker cp vue-build-env:/data/src/hpifu/${repository}/dist docker/
	docker build --tag=hatlonely/${repository}:${version} .
	sed 's/image: ${user}\/${repository}:.*$$/image: ${user}\/${repository}:${version}/g' stack.tpl.yml > stack.yml

.PHONY: deploy
deploy:
	docker stack deploy -c stack.yml ${repository}

.PHONY: remove
remove:
	docker stack rm ${repository}

dist:
	npm run build