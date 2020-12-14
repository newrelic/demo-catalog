# Getting Started - Deploy your first Demo Scenario

In this guide, you will learn how to:
* Create a user config file with your cloud (AWS, Azure or GCP) and New Relic credentials
* Select a deployment configuration file that describes the demo scenario
* Use the `demo-deployer` to create the demo environment

> **Note:** The instructions below reference your `<username>` and a `$HOME` path. The user is your typical user name on your local machine. `$HOME` is where your user profile is stored on your machine. On MacOS, this is typically `/Users/<username>`. On Linux, `/home/<username>`. On Windows, `C:\Users\<username>`.

## Prerequisites
* Make sure you have [Docker](https://docs.docker.com/get-docker/) installed
* Pull the latest version of the demo-deployer:
  ```console
  $ docker pull ghcr.io/newrelic/deployer:latest
  ```

### Create your configuration files

Create a directory in your home folder called `configs`:

```console
$ mkdir -p $HOME/demo-deployer/configs
```

You'll store your configuration files in this folder to make it easy for the deployer.

Next, follow the steps [here to create your local user config file](https://github.com/newrelic/demo-deployer/blob/main/documentation/user_config/README.md). You can store your local user config file at `$HOME/demo-deployer/configs/user.credentials.local.json` and the deployer will pick up your user configuration automatically. If you name your user config file differently, you will need to pass the '-c' flag with the path and name of your user config file.

## Select a demo scenario

Alongside the user configuration file, the deployer uses a **deployment configuration file** to manage resources in your cloud environment. You can build a deployment configuration file yourself, but we also offer a catalog of configurations that you can use to get started.

Select a demo scenario from the [demo catalog](catalog/README.md) and copy the demo url for use in the next step.

## Deploy your services

Now that you've set up your local environment and chosen a demo, you can deploy your services:

```console
$ docker run -it\
    -v $HOME/demo-deployer/configs/:/mnt/deployer/configs/\
    --entrypoint ruby ghcr.io/newrelic/deployer main.rb -d <demo-url>
```

Don't forget to replace `<demo-url>` with the url or local path to a deployment configuration file.

> **Technical Detail:** Any file dependency needed by the deployer needs to be explicitly handled through the use of a mounted volume (using `-v`). To make things simpler, we only mount your local `$HOME/demo-deployer/configs` directory so that all the files in that folder will be accessible by the docker image. The location for that `/configs` folder in the docker image will be `/mnt/deployer/configs`.
>
> If you're deploying to AWS, you'll want to make sure the .pem key path in your user config file is using the docker image path (`/mnt/deployer/configs/<filename>`).

This command spins up several services in the cloud provider of your choice, so it can take some time to run, depending on the demo. When it finishes, you should see some output stating that the deployment was successful:

```console
[INFO] Executing Deployment
[✔] Parsing and validating Deployment configuration success
[✔] Provisioner success
[✔] Installing On-Host instrumentation success
[✔] Installing Services and instrumentations success
[INFO] Deployment successful!

Deployed Resources:

...

Completed at 2020-08-11 11:27:00 -0700

[INFO] This deployment summary can also be found in:
[INFO]   /tmp/demo/deploy_summary.txt
```

## Tear down your resources

When you're finished with the demo, you can tear down all the services you created. To remove the deployment and all associated cloud resources, execute the deployer with the same command as before, but add the parameter `-t` to specify a teardown execution:

```console
$ docker run -it\
    -v $HOME/demo-deployer/configs/:/mnt/deployer/configs/\
    --entrypoint ruby ghcr.io/newrelic/deployer main.rb -d <demo-url> -t
[INFO] Executing Teardown
[✔] Parsing and validating Teardown configuration success
[✔] Provisioner success
[✔] Uninstalling On-Host instrumentation success
[✔] Uninstalling Services and instrumentations success
[✔] Terminating infrastructure success
[INFO] Teardown successful!
```

> **Note:** Don't forget to replace `<demo-url>` with the same value you used during deployment.

## Troubleshooting

You may see errors when running these docker commands, this section may help you diagnose these issues.

### Docker error

While running docker, you may see the error below:

```console
$ docker run -it\
    -v $HOME/demo-deployer/configs/:/mnt/deployer/configs/\
    --entrypoint ruby ghcr.io/newrelic/deployer main.rb -d <demo-url>
docker: Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?.
See ‘docker run --help’.
```

This typically happens when your docker application is not running (in the background). Find the Docker application on your machine, and start it. You should see the docker icon on your desktop indicating that docker is running. Then, you can try to deploy again.

### Deployer Debug verbosity

You may want to see a more detailed output of what the deployer is doing. You can add `-l debug` to make the output more verbose:

```console
$ docker run -it\
    -v /home/jerard/configs/:/mnt/deployer/configs/\
    --entrypoint ruby ghcr.io/newrelic/deployer main.rb -d <demo-url> -l debug
```
