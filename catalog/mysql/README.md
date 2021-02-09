# MySQL Demo
Get your first taste of New Relic infrastructure integrations with MySQL and the Open Install Library! This demo runs on a single host with a simulator, Node.js application, and a MySQL database. The Open Install Library is used to automatically instrument the host and MySQL instance with corresponding installation tasks.

## Prerequisites
* An environment set up by following the [Getting Started guide](../../GETTING_STARTED.md)
* A database password and root database password added to the `secrets` of your user configuration file. Like so:
  ```json
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
docker run -it -v $HOME/demo-deployer/configs/:/mnt/deployer/configs/ --entrypoint ruby ghcr.io/newrelic/deployer main.rb -d https://raw.githubusercontent.com/newrelic/demo-catalog/main/catalog/mysql/mysql.aws.json
```

#### Azure
```
docker run -it -v $HOME/demo-deployer/configs/:/mnt/deployer/configs/ --entrypoint ruby ghcr.io/newrelic/deployer main.rb -d https://raw.githubusercontent.com/newrelic/demo-catalog/main/catalog/mysql/mysql.azure.json
```

#### Google Cloud Platform
```
docker run -it -v $HOME/demo-deployer/configs/:/mnt/deployer/configs/ --entrypoint ruby ghcr.io/newrelic/deployer main.rb -d https://raw.githubusercontent.com/newrelic/demo-catalog/main/catalog/mysql/mysql.gcp.json
```

## Configurations
| AWS | Azure | GCP |
|---|---|---|
| [mysql.aws.json](https://raw.githubusercontent.com/newrelic/demo-catalog/main/catalog/mysql/mysql.aws.json) | [mysql.azure.json](https://raw.githubusercontent.com/newrelic/demo-catalog/main/catalog/mysql/mysql.azure.json) | [mysql.gcp.json](https://raw.githubusercontent.com/newrelic/demo-catalog/main/catalog/mysql/mysql.gcp.json) |

