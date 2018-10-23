# wp-docker-dev

Another attempt at an instant WordPress development environment

## Requirements

- Docker
- [docker-compose](https://docs.docker.com/compose/) 1.6+
- Ruby 1.9.3+ (for Rake)

## Setup

- Run `bundle install` to install Rake
- Copy `config-sample.json` to `config.json` and edit settings as
required (see below)
- Copy `conf/vhost-example.conf` to `conf/vhost.conf` and configure if
desired
- Run `rake start` to build and start the containers

## Usage

Once the containers have (hopefully) started successfully, you can
start adding your WordPress installs to `./data/www`. Each site should
go into its own subdirectory, e.g.

    data/www
    \-- ergonomi
     |-- index.php
     |-- latest.tar.gz
     |-- license.txt
     |-- readme.html
     |-- wp-activate.php
       ...
    \-- foo
     |-- index.php
     |-- license.txt
     |-- readme.html
     |-- wp-activate.php
       ...

You will also need to create databases for each of the installs. To do
this, simply run `rake dbshell` to enter the MariaDB console and
`create schema <name>`.  For simplicity (and since this is only meant
to be a development environment) the `root` user is the only user that
exists on the server (password `wordpress`) and is what can be used
for the installs. Obviously, feel free to create other users as
necessary.

Once WordPress has been extracted to the proper subdirectory, ensure
entries for your desired subdomains exist in your `/etc/hosts`
file, e.g.

    127.0.0.1    foo.wordpress.dev bar.wordpress.dev

One should be present for each subdomain and should point to the IP
address of the Docker host. After that, you should be able to access
sites at `http://<subdirectory>.wordpress.dev:8080` (by default,
otherwise depending on the configured `server_name` in `vhost.conf`).

### Volume mounts with SELinux

If you are using SELinux, under certain configurations you may have
permissions issues when containers try to write to the mounted
volumes. To get around this, you (hopefully) should just need to
append `:Z` to the volume mounts inside `docker-compose.yml`.

## Configuration

There is only one configuration option at the moment, but more may be
added if the need ever arises:

- `host-user-id`: your user ID (for volume permissions; run `id` to
  check)
