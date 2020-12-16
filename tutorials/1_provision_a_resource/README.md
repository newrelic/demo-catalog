[![Experimental Project header](https://github.com/newrelic/opensource-website/raw/master/src/images/categories/Experimental.png)](https://opensource.newrelic.com/oss-category/#experimental)

# Demo Catalog : Tutorial : Single Resource

If you have not got the demo-deployer setup please follow our [getting started guide](/GETTING_STARTED.md) and get your [AWS credentials setup](https://github.com/newrelic/demo-deployer/blob/main/documentation/user_config/aws.md) before working through this tutorial.

# Tutorial : How to build a demo: Deploying a single resource

In this first tutorial we will be creating a deploy configuration for a single resource provisioned in Amazon Web Services(AWS) public cloud.  All cloud resources are defined in a block called "resources" within a deployment configuration JSON file.  The demo-deployer will provision these resources using the user configuration credentials you provided in the demo-deployer setup.

[Example deployment configuration](single-resource.json):

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

In the above deployment configuration we define a single resource that will be provisioned.  Here is a quick summary of what each of the fields mean:

| Field Name    |  Field Description |
| ------------- | ------------------ |
| id            | is used for naming the resource and will be used later to target this resource for software installation and instrumentation setup |
| provider      | specifies which supported cloud provider we are going to attempt to provision the resource in  |
| type          | is the type of resource to be provisioned       |
| size          | specifies the specific ec2 size you want provisioned |

Do note that these are the fields for creating a EC2 resource in AWS. There are slightly different fields for each resource type and cloud provider.

## Provisioning the single resource
To run this deployment and provision a single resource you can execute this command:

```
docker run -it\
    -v $HOME/demo-deployer/configs/:/mnt/deployer/configs/\
    --entrypoint ruby ghcr.io/newrelic/deployer main.rb\
    -d https://raw.githubusercontent.com/newrelic/demo-catalog/main/tutorials/1_provision_a_resource/single-resource.json
```

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
[INFO]   /tmp/user-single-resource/deploy_summary.txt
```

If you take the IP address for your resource you can access it via SSH.

    ssh ec2-user@XX.XXX.XX.XXX -i PATH/TO/YOUR/PEM_KEY.pem


## Tearing down the single resource
To tear down the single resource you can execute this command:

```
docker run -it\
    -v $HOME/demo-deployer/configs/:/mnt/deployer/configs/\
    --entrypoint ruby ghcr.io/newrelic/deployer main.rb\
    -d https://raw.githubusercontent.com/newrelic/demo-catalog/main/tutorials/1_provision_a_resource/single-resource.json\
    --teardown
```
