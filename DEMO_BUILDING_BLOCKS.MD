# Demo Building Blocks

If you are looking to build your own demo a good place to start would be the [tutorials](/tutorials/README.md) in this repo.  The tutorials will give you an overview of the main areas of demo deployment configuration file.

All the demo building blocks outlines here are meant to be used with the [demo-deployer](https://github.com/newrelic/demo-deployer).  The demo-deployer works behind the scene to create cloud resources, install services and setup instrumentation.

## Cloud Providers

The demo-deployer has support for deploying resources into three public clouds: Azure, Google Cloud Computer(GCP) and Amazon Web Services(AWS).  Below you will find a list of the current support resource type for each cloud provider.

### [AWS](https://github.com/newrelic/demo-deployer/tree/main/documentation/deploy_config/resources#aws)

* [EC2](https://github.com/newrelic/demo-deployer/blob/main/documentation/deploy_config/resources/aws/ec2/README.md)
* [Lambda](https://github.com/newrelic/demo-deployer/blob/main/documentation/deploy_config/resources/aws/lambda/README.md)
* [ELBs](https://github.com/newrelic/demo-deployer/blob/main/documentation/deploy_config/resources/aws/elb/README.md)
* [Route53](https://github.com/newrelic/demo-deployer/blob/main/documentation/deploy_config/resources/aws/route53/README.md)
* [S3](https://github.com/newrelic/demo-deployer/blob/main/documentation/deploy_config/resources/aws/s3/README.md)

### [Azure](https://github.com/newrelic/demo-deployer/tree/main/documentation/deploy_config/resources#azure)

* [VM](https://github.com/newrelic/demo-deployer/blob/main/documentation/deploy_config/resources/azure/vm/README.md)

### [GCP](https://github.com/newrelic/demo-deployer/tree/main/documentation/deploy_config/resources#gcp)

* [Compute](https://github.com/newrelic/demo-deployer/blob/main/documentation/deploy_config/resources/gcp/compute/README.md)

## [Services](https://github.com/newrelic/demo-deployer/tree/main/documentation/deploy_config/services)

The demo-deployer can install a variety of different services onto cloud resources.  These services are refereed to a 'trons' and provide a simple rest interface to a well defined set of APIs.

### What is a tron

A 'tron' is a simple service that could be written in any language.  Each tron supports a simple set of HTTP Apis.  This allows for interchanging each tron for another.  For example you can build a demo deployment with Java services and later swap one or more out for Node with any issues.

#### Tron Supported APIs

* /api/inventory
* /api/inventory/[1-10]
* /api/validateMessage?message=[xxx]

###  Languages/Trons

* [Nodetron](https://github.com/newrelic/demo-nodetron)
* [Javatron](https://github.com/newrelic/demo-javatron)
* [Pythontron](https://github.com/newrelic/demo-pythontron)

### [Behaviors](https://github.com/newrelic/demo-deployer/tree/main/documentation/developer/behaviors)

Each tron implements a set of behaviors that can be triggered at runtime.  These behaviors are only executed when the tron receives a specific HTTP header as part of an incoming request.

Current Behaviors
* [Throw](throw/README.md)
* [Compute](compute/README.md)
* [Memory Allocation](malloc/README.md)

### Driving traffic

To drive traffic over a service tron the [demo-simulator](https://github.com/newrelic/demo-simulator) is a great fit.  The simulator is a simple NodeJS based web service that can be configured drive traffic to a set of services or HTML pages.  The simulator can be configured to run many different [scenarios](https://github.com/newrelic/demo-simulator#scenario).

## [Instrumentation](https://github.com/newrelic/demo-newrelic-instrumentation)

Instrumentation can be setup for most of the resources and service that are currently supported by the demo-deployer. Setting up instrumentation allows for getting insights into the inner workings of the resource and services.

* [Host](https://github.com/newrelic/demo-newrelic-instrumentation#on-hostinfrastructure)
* Services
  * [Java](https://github.com/newrelic/demo-newrelic-instrumentation#java)
  * [Python](https://github.com/newrelic/demo-newrelic-instrumentation#python)
  * [Node](https://github.com/newrelic/demo-newrelic-instrumentation#nodejs)
* [Logs](https://github.com/newrelic/demo-newrelic-instrumentation#python)
* [Alerts](https://github.com/newrelic/demo-newrelic-instrumentation#python)
* [Dashboards](https://github.com/newrelic/demo-newrelic-instrumentation#python)


