# Run Apache Knox in Docker

## Acknowledgement
This repository is forked from [pfisterer/apache-knox-docker](https://github.com/pfisterer/apache-knox-docker), and based on additional information from the following (ordered alphabetically):
* [Adding a service to Apache Knox](https://cwiki.apache.org/confluence/display/KNOX/2015/12/17/Adding+a+service+to+Apache+Knox)
* [Dynamic HA Provider Configuration](https://cwiki.apache.org/confluence/display/KNOX/Dynamic+HA+Provider+Configuration)
* [How to load balance several phoenix query servers behind Knox gateway?](https://stackoverflow.com/questions/56600584/how-to-load-balance-several-phoenix-query-servers-behind-knox-gateway)
* [Securing Raspberry Pi Security Camera (or UIs) using Apache Knox](https://webcache.googleusercontent.com/search?q=cache:bryL69c-mlYJ:https://www.srmore.io/posts/securing_raspberry_pi_security_camera/&hl=en&gl=il)
* [Tools for Running Knox in Docker](https://pzampino.github.io/2018/10/25/docker-tools-for-knox.html)

## Goal
This repository was created to demonstrate the ability of [Apache Knox](https://knox.apache.org/https://knox.apache.org/) to be a generic gateway for any service (not restricted to Hadoop), with high-availability.

## How to use


## Structure
The 





Docker container for [Apache Knox](https://knox.apache.org/), which is an Application Gateway for interacting with the REST APIs and UIs of Apache Hadoop deployments. The image is available on Dockerhub: <https://cloud.docker.com/u/farberg/repository/docker/farberg/apache-knox-docker>.

A helm chart for deployment on k8s is available here: [pfisterer/apache-knox-helm](https://github.com/pfisterer/apache-knox-helm).

## Available versions

| Apache Knox Version | Docker Tag                        |
| ------------------- | --------------------------------- |
| latest              | farberg/apache-knox-docker:latest |
| 1.6.1               | farberg/apache-knox-docker:1.6.1  |
| 1.5.0               | farberg/apache-knox-docker:1.5.0  |
| 1.4.0               | farberg/apache-knox-docker:1.4.0  |
| 1.3.0               | farberg/apache-knox-docker:1.3.0  |

Example (required for the commands below to work)

```bash
export KNOX_VERSION=1.6.1
```

## Run Apache Knox in Docker

Using the default configuration files:

```bash
docker run --rm -ti farberg/apache-knox-docker:$KNOX_VERSION
```
Using your own configuration files:

```bash
docker run --rm -ti -v /path/to/your/config:/opt/knox/conf farberg/apache-knox-docker:$KNOX_VERSION

# Example on MacOS/Linux: 
# docker run --rm -ti -v $PWD/my-conf/:/opt/knox/conf/ farberg/apache-knox-docker:$KNOX_VERSION
# docker run --rm -ti -v $PWD/my-conf-1.4.0/:/opt/knox/conf/ farberg/apache-knox-docker:$KNOX_VERSION
# docker run --rm -ti -v $PWD/my-conf-1.5.0/:/opt/knox/conf/ farberg/apache-knox-docker:$KNOX_VERSION
# docker run --rm -ti -v $PWD/my-conf-1.6.1/:/opt/knox/conf/ farberg/apache-knox-docker:$KNOX_VERSION
```

## Build and push this Docker container

```bash
docker login
docker buildx build --push --platform "linux/arm64,linux/amd64" -t farberg/apache-knox-docker:latest -t farberg/apache-knox-docker:$KNOX_VERSION .
```
