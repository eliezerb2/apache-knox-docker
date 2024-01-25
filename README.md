# Run Apache Knox in Docker

## Acknowledgement
This repository is forked from [pfisterer/apache-knox-docker](https://github.com/pfisterer/apache-knox-docker), and based on additional information from the following (ordered alphabetically):
* [Adding a service to Apache Knox](https://cwiki.apache.org/confluence/display/KNOX/2015/12/17/Adding+a+service+to+Apache+Knox)
* [Dynamic HA Provider Configuration](https://cwiki.apache.org/confluence/display/KNOX/Dynamic+HA+Provider+Configuration)
* [How to load balance several phoenix query servers behind Knox gateway?](https://stackoverflow.com/questions/56600584/how-to-load-balance-several-phoenix-query-servers-behind-knox-gateway)
* [Securing Raspberry Pi Security Camera (or UIs) using Apache Knox](https://webcache.googleusercontent.com/search?q=cache:bryL69c-mlYJ:https://www.srmore.io/posts/securing_raspberry_pi_security_camera/&hl=en&gl=il)
* [Tools for Running Knox in Docker](https://pzampino.github.io/2018/10/25/docker-tools-for-knox.html)

## Goal
This repository was created to demonstrate the ability of [Apache Knox](https://knox.apache.org) to be a generic gateway for any service (not restricted to Hadoop), with high-availability.

## How to use
Use the following credentials:\
Username - admin\
Password - admin-password
* Use Docker Compose to start all services 
* Use a browser to access [Service A](https://localhost:8445/gateway/anyservice/servicea/index.html)
* Stop servicea1 Docker container
* Refresh the page...

You can also access the [Knox Admin UI](https://localhost:8445/gateway/manager/admin-ui/)

## Repository Structure
The following diagram depicts the structure of the repository:
![Repository structure](Design/RepositoryStructure.drawio.svg#gh-dark-mode-only)

## Knox design
The following diagram depicts the design of the Knox implementation:
![Repository structure](Design/KnoxDesign.drawio.svg#gh-dark-mode-only)
