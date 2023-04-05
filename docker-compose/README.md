# [docker-compose](https://community.chocolatey.org/packages/docker-compose)[![](http://transparent-favicon.info/favicon.ico)](#)

Docker Compose is a tool for running multi-container applications on Docker defined using the Compose file format.  
A Compose file is used to define how one or more containers that make up your application are configured ([overview](https://docs.docker.com/compose/)).

This package contains Docker Compose V2 which is not a standalone binary anymore.  
Therefore it depends on the [docker-cli](https://community.chocolatey.org/packages/docker-cli) package. 
To use Compose V2 through Docker type `docker compose ...`.

Docker Inc.'s support for Compose V1 and its Syntax (`docker-compose ...`) will end after June 2023 ([link](https://docs.docker.com/compose/migrate/)).  
This package will provide the old Syntax until then.