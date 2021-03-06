[![Experimental Project header](https://github.com/newrelic/opensource-website/raw/master/src/images/categories/Experimental.png)](https://opensource.newrelic.com/oss-category/#experimental)

# Demo Catalog : Tutorial : Install a Service

If you have not got the demo-deployer setup please follow our [getting started guide](/GETTING_STARTED.md) and get your [AWS credentials](https://github.com/newrelic/demo-deployer/blob/main/documentation/user_config/aws.md) and [New Relic credentials](https://github.com/newrelic/demo-deployer/blob/main/documentation/user_config/newrelic.md) setup before working through this tutorial

# Tutorial : How to build a demo: Installing a Service

In this second tutorial we will be building on the [first tutorial](../1_provision_a_resource) provisioning a resource and then installing a service on the resource.  Anything that will be installed on a resource is defined in a block called "services" within a deployment configuration file.

[Example deployment configuration](single-service.json):

```
{
  "resources": [
    {
      "id": "compute",
      "provider": "aws",
      "type": "ec2",
      "size": "t2.micro"
    }
  ],
  "services": [
    {
      "id": "nodetron",
      "display_name": "Nodetron Service",
      "source_repository": "https://github.com/newrelic/demo-nodetron.git",
      "deploy_script_path": "/deploy/linux/roles",
      "port": 5000,
      "relationships": [],
      "destinations": ["compute"]
    }
  ]
}
```

In the above configuration we define a single service that will be installed on the "compute" resource.  Here is a quick summary of what each of the service fields mean:

| Field Name         |  Field Description |
| ------------------ | ------------------ |
| id                 | is used for referring to the service for defining relationships and for instrumentation targeting |
| display_name       | is used by instrumentation as the service display name  |
| source_repository  | the local path or git repo where the code for the service lives |
| deploy_script_path | the location of the Ansible play that will be invoked to actually install the service |
| port               | the port that the service will be listening on and will be opened for communication on the resource |
| relationships      | the other services this service will communicate with |
| destinations       | the resource that this service will be installed on |


## Installing the single service on a resource

```
docker run -it\
    -v $HOME/demo-deployer/configs/:/mnt/deployer/configs/\
    --entrypoint ruby ghcr.io/newrelic/deployer main.rb\
    -d https://raw.githubusercontent.com/newrelic/demo-catalog/main/tutorials/2_install_a_service/single-service.json
```

## After installing the single service

Once the demo-deployer is done you should get a nice output showing you what was deployed and how to access it.

```
[INFO] Deployment successful!


Deployed Resources:

  compute (aws/ec2):
    ip: XX.XXX.XXX.XX
    services: ["service"]


Installed Services:

  service:
    url: http://XX.XXX.XXX.XX:5000

Completed at 2020-12-15 19:07:47 +0000

[INFO] This deployment summary can also be found in:
[INFO]   /tmp/user-single-service/deploy_summary.txt
```

If you take the URL from the output and paste it into a web browser you will see the Nodetron services web UI.

## Tearing down the single resource and service
To tear down the single resource and service you can execute this command:

```
docker run -it\
    -v $HOME/demo-deployer/configs/:/mnt/deployer/configs/\
    --entrypoint ruby ghcr.io/newrelic/deployer main.rb\
    -d https://raw.githubusercontent.com/newrelic/demo-catalog/main/tutorials/2_install_a_service/single-service.json\
    --teardown
```
