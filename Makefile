.PHONY: develop-image image run

IMAGE=rust-lambda-container-example
UID:=`id -u`
GID:=`id -g`
PWD:=`pwd`

develop-image:
	docker build --build-arg UID=${UID} --build-arg GID=${GID} \
		-t ${IMAGE}:develop .

image:
	docker build -t ${IMAGE}:latest .

run:
	docker run -it --rm --mount type=bind,source="${PWD}/target/debug/rust-lambda-container-example",target=/var/runtime/bootstrap \
		-p 9000:8080 \
		public.ecr.aws/lambda/provided:al2 handler
