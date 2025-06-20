# <img src="https://rawcdn.githack.com/geicht/chocolatey-packages/b3c81e45a778107adcf596a8873cd5911996299d/docker-compose/img/docker-compose.png" width="48" height="48"/> [docker-compose](https://community.chocolatey.org/packages/docker-compose)[![](http://transparent-favicon.info/favicon.ico)](#)[![Latest version](https://repology.org/badge/version-for-repo/chocolatey/docker-compose.svg?header=Latest%20version)](https://community.chocolatey.org/packages/docker-compose/2.37.2)

Docker Compose is a tool for running multi-container applications on Docker defined using the Compose file format.  
A Compose file is used to define how one or more containers that make up your application are configured ([overview](https://docs.docker.com/compose/)).

This package contains Docker Compose V2 which is not a standalone binary anymore.  
Therefore it depends on the [docker-cli](https://community.chocolatey.org/packages/docker-cli) package. 
To use Compose V2 through Docker type `docker compose ...`.

From July 2023 Docker Inc.'s support for Compose V1 and its Syntax (`docker-compose ...`) has ended ([link](https://docs.docker.com/compose/migrate/)).  
