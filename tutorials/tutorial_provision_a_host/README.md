[![Experimental Project header](https://github.com/newrelic/opensource-website/raw/master/src/images/categories/Experimental.png)](https://opensource.newrelic.com/oss-category/#experimental)

# Demo Catalog : Tutorial : Single Host

If you have not got the demo-deployer setup please follow our [getting started guide](/GETTING_STARTED.md) and get your AWS credential setup before working through this tutorial.

# Tutorial : How to build a demo: Deploying a single host

In this first tutorial we will be creating a deploy configuration for a single host provisioned in Amazon Web Services(AWS) public cloud.  All cloud resources are defined in a block called ‘resources’ within a deployment configuration JSON file.  The demo-deployer will provision these resources using the user configuration credentials you provided in the demo-deployer setup.

[Example deploy configuration](single-host.json):

```
{
  "resources": [
    {
      "id": "compute",
      "provider": "aws",
      "type": "ec2",
      "size": "t2.micro"
    }
  ]
}
```

In the above configuration we define a single resource that will be provisioned.  Here is a quick summary of what each of the fields mean:

| Field Name    |  Field Description |
| ------------- | ------------------ |
| id            | 'id' is used for naming the resource and will be used later to target this resource for software installation and instrumentation setup |
| provider      | 'provider' specifies which supported cloud provider we are going to attempt to provision the resource in  |
| type          | 'type' is the type of resource to be provisioned       |
| size          | 'size' specifies the specific ec2 size you want provisioned |

Do note that these are the fields only for creating a resource in AWS.  There are slightly different fields for each cloud providers compute instances.

## Provisioning the single host
To run this deployment and provision a single host you can execute this command:

```
docker run -it\
    -v $HOME/demo-deployer/configs/:/mnt/deployer/configs/\
    --entrypoint ruby ghcr.io/newrelic/deployer main.rb\
    -d https://raw.githubusercontent.com/newrelic/demo-catalog/DEMO-2499-tutorial-single-host/tutorials/tutorial_single_host/single-host.json
```

*TODO: remove 'DEMO-2499-tutorial-single-host' before merging*

## After installing the single service

Once the demo-deployer is done you should get nice output showing you what was deployed.

```
[INFO] Deployment successful!


Deployed Resources:

  compute (aws/ec2):
    ip: XX.XXX.XX.XXX


Installed Services:

Completed at 2020-12-15 19:21:15 +0000

[INFO] This deployment summary can also be found in:
[INFO]   /tmp/user-single-host/deploy_summary.txt
```

If you take the IP address for your host you can access it via SSH.

    ssh ec2-user@XX.XXX.XX.XXX -i PATH/TO/YOUR/PEM_KEY.pem


## Tearing down the single host
To tear down the single host you can execute this command:

```
docker run -it\
    -v $HOME/demo-deployer/configs/:/mnt/deployer/configs/\
    --entrypoint ruby ghcr.io/newrelic/deployer main.rb\
    -d https://raw.githubusercontent.com/newrelic/demo-catalog/DEMO-2499-tutorial-single-host/tutorials/tutorial_single_host/single-host.json -t
```

*TODO: remove 'DEMO-2499-tutorial-single-host' before merging*
