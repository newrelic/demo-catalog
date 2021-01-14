# MySQL Demo
Get your first taste of New Relic infrastructure integrations with MySQL! This demo runs on a single host with a simulator, Node.js application, and a MySQL database.

## Prerequisites
* An environment set up by follow the [Getting Started guide](../../GETTING_STARTED.md)
* A database password and root password added to the `secrets` of your user configuration file. Like so:
  ```
  {
  ...

    "secrets": {
      "database_password": "<a secure password>",
      "database_root_password": "<a secure password>"
    }
  }
  ```
  Read more about the `secrets` field [here](https://github.com/newrelic/demo-deployer/blob/main/documentation/user_config/secrets.md)

## Guide
When your environment is ready to go, use one of the commands below to deploy your application.

#### AWS
```
docker run -it -v $HOME/demo-deployer/configs/:/mnt/deployer/configs/ --entrypoint ruby ghcr.io/newrelic/deployer DEMO-2498-mysql-integration.rb -d https://raw.githubusercontent.com/newrelic/demo-catalog/DEMO-2498-mysql-integration/catalog/mysql/mysql.aws.json
```

#### Azure
```
docker run -it -v $HOME/demo-deployer/configs/:/mnt/deployer/configs/ --entrypoint ruby ghcr.io/newrelic/deployer DEMO-2498-mysql-integration.rb -d https://raw.githubusercontent.com/newrelic/demo-catalog/DEMO-2498-mysql-integration/catalog/mysql/mysql.azure.json
```

#### Google Cloud Platform
```
docker run -it -v $HOME/demo-deployer/configs/:/mnt/deployer/configs/ --entrypoint ruby ghcr.io/newrelic/deployer DEMO-2498-mysql-integration.rb -d https://raw.githubusercontent.com/newrelic/demo-catalog/DEMO-2498-mysql-integration/catalog/mysql/mysql.gcp.json
```

## Configurations
| AWS | Azure | GCP |
|---|---|---|
| [mysql.aws.json](https://raw.githubusercontent.com/newrelic/demo-catalog/DEMO-2498-mysql-integration/catalog/mysql/mysql.aws.json) | [mysql.azure.json](https://raw.githubusercontent.com/newrelic/demo-catalog/DEMO-2498-mysql-integration/catalog/mysql/mysql.azure.json) | [mysql.gcp.json](https://raw.githubusercontent.com/newrelic/demo-catalog/DEMO-2498-mysql-integration/catalog/mysql/mysql.gcp.json) |

