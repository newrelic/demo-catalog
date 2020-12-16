[![Experimental Project header](https://github.com/newrelic/opensource-website/raw/master/src/images/categories/Experimental.png)](https://opensource.newrelic.com/oss-category/#experimental)

# Demo Catalog : Tutorial : Instrument a Resource and Service

If you have not got the demo-deployer setup please follow our [getting started guide](/GETTING_STARTED.md) and get your AWS and New Relic credential setup before working through this tutorial.

# Tutorial : How to build a demo: Instrumentation a resource and service

In this third tutorial we will be creating a deploy configuration that will provision a single resource, install a service on that resource and setup New Relic instrumentation on both.  All instrumentation is defined in a block called "instrument" within a deployment configuration JSON file.  The demo-deployer will install and setup the New Relic instrumentation using the user configuration credentials you provided in the demo-deployer setup.


[Example deploy configuration](instrumentation.json):

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
  ],
	"instrumentations": {
    "resources": [
      {
        "id": "nr_infra",
        "resource_ids": ["compute"],
        "provider": "newrelic",
        "source_repository": "-b main https://github.com/newrelic/demo-newrelic-instrumentation.git",
        "deploy_script_path": "deploy/linux/roles",
        "version": "1.12.1"
      }
    ],
    "services": [
      {
        "id": "nr_node_agent",
        "service_ids": ["nodetron"],
        "provider": "newrelic",
        "source_repository": "-b main https://github.com/newrelic/demo-newrelic-instrumentation.git",
        "deploy_script_path": "deploy/node/linux/roles",
        "version": "6.11.0"
      }
    ]
  }
}
```

In the above configuration we define two instrumentation blocks that setup the on resource and in service New Relic instrumentation. Here is a quick summary of what each of the service fields mean:

| Field Name               |  Field Description |
| ------------------------ | ------------------ |
| id                       | used for referring to other instrumentation  |
| resource_ids/service_ids | the resource or service ids to target with instrumentation  |
| provider                 | the instrumentation provider |
| source_repository        | the local path or git repo where the code for the service lives |
| deploy_script_path       | the location of the Ansible play that will be invoked to actually install the service |
| version                  | the version of the instrumentation to be installed |

## Installing the single service on a resource

```
docker run -it\
    -v $HOME/demo-deployer/configs/:/mnt/deployer/configs/\
    --entrypoint ruby ghcr.io/newrelic/deployer main.rb\
    -d https://raw.githubusercontent.com/newrelic/demo-catalog/DEMO-2499-tutorial-single-host/tutorials/3_tutorial_instrument_resource_and_service/instrumentation.json
```

*TODO: remove 'DEMO-2499-tutorial-single-host' before merging*

## After installing the single service

Once the demo-deployer is done you should get a nice output showing you what was deployed and how to access it.

```
[INFO] Deployment successful!


Deployed Resources:

  compute (aws/ec2):
    ip: XX.XXX.XXX.XX
    services: ["nodetron"]
    instrumentation:
       nr_infra: newrelic v1.12.1


Installed Services:

  nodetron:
    url: http://XX.XXX.XXX.XX:5000
    instrumentation:
       nr_node_agent: newrelic v6.11.0

Completed at 2020-12-16 00:22:14 +0000

[INFO] This deployment summary can also be found in:
[INFO]   /tmp/user-instrumentation/deploy_summary.txt
```

If you visit your New Relic One account you will be able to find two entities: "Nodetron Service" and "compute".

## Tearing down
To tear down the single resource, service and instrumentation you can execute this command:

```
docker run -it\
    -v $HOME/demo-deployer/configs/:/mnt/deployer/configs/\
    --entrypoint ruby ghcr.io/newrelic/deployer main.rb\
    -d https://raw.githubusercontent.com/newrelic/demo-catalog/DEMO-2499-tutorial-single-host/tutorials/3_tutorial_instrument_resource_and_service/instrumentation.json\
    --teardown
```

*TODO: remove 'DEMO-2499-tutorial-single-host' before merging*



