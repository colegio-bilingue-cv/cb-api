# Colegio Bilingüe Ciudad Vieja

## Prerequisites

* docker
* docker-compose

Recommended:

* TablePlus or DBeaver

## Database creation

The first time the `bin/start` script runs, it will create the development and test databases.

## Connect to the development database using a client tool

The PostgreSQL port within docker container is published as port 5433.

DB url:

```
postgresql://user:password@127.0.0.1:5433/db-name
```

## Run project locally (using docker)

Execute the following script:

```
$ ./bin/start
```

Then you can hit the api on the following url http://localhost:3000/

## Run tests (using docker)

First, run a terminal in a docker container:

```
$ ./bin/terminal
```

Run the tests:

```
% bundle exec rspec
```

The tests and application code is mounted in a shared volume with your host machine, so it's not needed to restart the terminal once you write new code.

## Run Rails commands (using docker)


First, run a terminal in a docker container:

```
$ ./bin/terminal
```

Then run Rails commands as usual:

```
% bin/rake db:migrate
```

```
% bin/rails routes
```

## Seed Local Database (Development)

First, run a terminal in a docker container:

```
$ ./bin/terminal
```

Then run the Rake task:

```
% bin/rake seed_dev
```

## Issues with Ubuntu package manager docker compose version

Run the docker compose ubuntu installer:

```
bash docker_compose_ubuntu_installer.sh
```
