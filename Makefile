repository=vue-tool
user=hatlonely
version=$(shell git describe --tags)

.PHONY: buildenv
buildenv:
	docker run --name vue-build-env -d node:12.8.1-alpine tail -f /dev/null

.PHONY: image
image:
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