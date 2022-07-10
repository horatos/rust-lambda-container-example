# rust-lambda-container-example

This repository contains an example of a Lambda container image with a handler written in Rust.

## Usage

### Build development image

First, you build a development image whose base image is `public.ecr.aws/lambda/provided:al2`, which is the custom base image for Lambda container images.

You execute the command `make develop-image`.

### Build the handler

You build the handler with the script `cargo` in this directory.
This script runs the cargo inside the development container.

### Run the Lambda container image on your PC

You can run it with `make run`. This make target runs the Lambda container.
You can check the response of the handler by executing the following command in another console.

```console
curl -XPOST http://localhost:9000/2015-03-31/functions/function/invocations -d '{"message": "ping", "id": 10}'
```

### Build and Deploy

You build the production image with `make image` and push the image `rust-lambda-container-example:latest` to your ECR repository.

Then, you create a Lambda function with the image you pushed.
It can be invoked by executing `aws lambda invoke`.

## Caveat

The image `provided:al2` contains the AWS Lambda Runtime Interface Emulator.
This emulator only support the invocation through the API `Invoke`, which can be called with `aws lambda invoke`.

The Runtime Interface Emulator does not support Lambda Function URLs emulation.
The payloads of lambda events are different.
That of Lambda Function URLs contains the information of the HTTP request.
