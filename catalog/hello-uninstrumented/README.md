# Hello Uninstrumented Demo
This demo provides a quick way to get a Node.js service up and running on AWS in an EC2 T3.micro instance without New Relic instrumentation. Allowing anyone to add instrumentation themselves.

## Prerequisites
* If you don't have an environment set up yet, follow the [Getting Started guide](../../GETTING_STARTED.md)

## Guide
When your environment is ready to go, use one of the commands below to deploy your application.

#### AWS
```
docker run -it -v $HOME/demo-deployer/configs/:/mnt/deployer/configs/ ghcr.io/newrelic/deployer -d https://raw.githubusercontent.com/newrelic/demo-catalog/main/catalog/hello-uninstrumented/hello-uninstrumented.aws.json
```

## Configurations
| AWS | 
|---|
| [hello.aws.json](https://raw.githubusercontent.com/newrelic/demo-catalog/main/catalog/hello-uninstrumented/hello-uninstrumented.aws.json) |
