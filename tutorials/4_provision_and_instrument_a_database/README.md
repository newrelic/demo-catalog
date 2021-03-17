[![Experimental Project header](https://github.com/newrelic/opensource-website/raw/master/src/images/categories/Experimental.png)](https://opensource.newrelic.com/oss-category/#experimental)

# Demo Catalog : Tutorial : Provision and instrument a database

If you have not got the demo-deployer setup please follow our [getting started guide](/GETTING_STARTED.md) and get your AWS and New Relic credential setup before working through this tutorial.

# Tutorial : How to build a demo: Provisioning and instrumenting a database

This tutorial will show you how to provision and instrument a database service -- mysql for this tutorial -- as well as how to reference the database service from another service within the deployment config.

If you haven't seen or interacted with `merge fields` in the V3 deployer before, the configuration file shown below may look confusing. You can read all about `merge fields` [here](https://github.com/newrelic/demo-deployer/tree/main/documentation/deploy_config/merge_fields).

## Additional User Configuration Setup

The database resource requires changes to your user configuration file. You will need to add a new field -- `secrets` -- in the credentials field. The documentation for this field can be found [here](https://github.com/newrelic/demo-deployer/blob/main/documentation/user_config/secrets.md).

Your user configuration file should then look something like:

```json
{
    "credentials": {
        "aws": {
        },
        "azure": {
        },
        "newrelic": {
        },
        "secrets": {
            "database_password": "fake_example_password",
            "database_root_password": "fake_example_password"
        }
    },
    "globalTags": {}
}
```

Here is a summary of each field within secrets:

| Field Name               |  Field Description |
| ------------------------ | ------------------ |
| database_password        | used for the service to connect to the database |
| database_root_password   | specifically for connecting to the database with the root user |

## [Example deployment configuration](database.json)

```json
{
    "services": [
        {
            "id": "pythontron",
            "source_repository": "-b main https://github.com/newrelic/demo-pythontron.git",
            "deploy_script_path": "deploy/linux/roles",
            "port": 5001,
            "destinations": [
                "host1"
            ],
            "params": {
                "delay_start_ms": 10000,
                "database_user": "[service:mysql:params:database_user]",
                "database_password": "[credential:secrets:database_password]",
                "database_host": "[resource:host1:ip]",
                "database_port": "[service:mysql:port]"
            }
        },
        {
            "id": "mysql",
            "source_repository": "-b main https://github.com/newrelic/demo-services.git",
            "deploy_script_path": "deploy/mariadb/linux/roles",
            "port": 6002,
            "destinations": [
                "host1"
            ],
            "params": {
                "database_user": "demotron",
                "database_password": "[credential:secrets:database_password]",
                "database_root_password": "[credential:secrets:database_root_password]"
            }
        }
    ],
    "resources": [
        {
            "id": "host1",
            "provider": "aws",
            "type": "ec2",
            "size": "t3.micro"
        }
    ],
    "instrumentations": {
        "resources": [
            {
                "id": "nr_infra",
                "resource_ids": [
                    "host1"
                ],
                "provider": "newrelic",
                "source_repository": "-b main https://github.com/newrelic/demo-newrelic-instrumentation.git",
                "deploy_script_path": "deploy/linux/roles",
                "version": "1.14.2"
            }
        ],
        "services": [
            {
                "id": "mysql_integration",
                "service_ids": [
                    "mysql"
                ],
                "provider": "newrelic",
                "source_repository": "-b main https://github.com/newrelic/demo-newrelic-instrumentation.git",
                "deploy_script_path": "deploy/databases/mysql/linux/roles",
                "version": "1.4.0",
                "params": {
                    "database_port": "[service:mysql:port]"
                }
            }
        ]
    }
}
```

Here is a summary of the database fields within the config:

| Field Name               |  Field Description |
| ------------------------ | ------------------ |
| database_user            | name of database user created |
| database_password        | password created for database_user |
| database_host            | ip address of the host the database is running on |
| database_port            | port to connect to |
| database_root_password   | password created for the root user |

### Note - Params

Params is a dynamic field where any key, value pair entered is passed unto the underlying play. This is the general functionality of params across sections. Within a particular section, params may be validated & treated differently, as well as different params being needed in order for a play to successfully run.

## Running the deployment

```shell
docker run -it\
    -v $HOME/demo-deployer/configs/:/mnt/deployer/configs/\
    --entrypoint ruby ghcr.io/newrelic/deployer main.rb\
    -d https://raw.githubusercontent.com/newrelic/demo-catalog/main/tutorials/4_provision_and_instrument_a_database/database.json
```

## Deployment output

Once the demo-deployer is done you should get a nice output showing you what was deployed and how to access it.

```shell
[INFO] Deployment successful!


Deployed Resources:

  host1 (aws/ec2):
    ip: XX.XX.XXX.XXX
    services: ["pythontron", "mysql"]
    instrumentation: 
       nr_infra: newrelic v1.14.2 


Installed Services:

  pythontron:
    url: http://XX.XX.XXX.XXX:5001

  mysql:
    url: http://XX.XX.XXX.XXX:6002
    instrumentation: 
       mysql_integration: newrelic v1.4.0 

Completed at 2021-03-16 22:30:06 +0000

[INFO] This deployment summary can also be found in:
[INFO]   /tmp/user-crap2/deploy_summary.txt
```

As an example, if you have the mysql client installed locally, you would be able to connect to it with a command similar to the following:

`mysql -u root -p --host XX.XX.XXX.XXX --port 6002`

Additionally, if you visit your New Relic One account you will be able to find a new mysql node (under on host integration).

## Tearing down

To tear down the deployment, you can execute this command:

```shell
docker run -it\
    -v $HOME/demo-deployer/configs/:/mnt/deployer/configs/\
    --entrypoint ruby ghcr.io/newrelic/deployer main.rb\
    -d https://raw.githubusercontent.com/newrelic/demo-catalog/main/tutorials/4_provision_and_instrument_a_database/database.json\
    --teardown
```
