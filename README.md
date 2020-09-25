# hub.docker.com/r/tiredofit/cachet

[![Build Status](https://img.shields.io/docker/build/tiredofit/cachet.svg)](https://hub.docker.com/r/tiredofit/cachet)
[![Docker Pulls](https://img.shields.io/docker/pulls/tiredofit/cachet.svg)](https://hub.docker.com/r/tiredofit/cachet)
[![Docker Stars](https://img.shields.io/docker/stars/tiredofit/cachet.svg)](https://hub.docker.com/r/tiredofit/cachet)
[![Docker Layers](https://images.microbadger.com/badges/image/tiredofit/cachet.svg)](https://microbadger.com/images/tiredofit/cachet)

## Introduction

This will build a container for [Cachet](https://cachethq.io/) - An open source status page.

* This Container uses a [customized Alpine base](https://hub.docker.com/r/tiredofit/alpine) which includes [s6 overlay](https://github.com/just-containers/s6-overlay) enabled for PID 1 Init capabilities, [zabbix-agent](https://zabbix.org) for individual container monitoring, Cron also installed along with other tools (bash,curl, less, logrotate, nano, vim) for easier management. It also supports sending to external SMTP servers..

[Changelog](CHANGELOG.md)

## Authors

- [Dave Conroy](https://github.com/tiredofit)

## Table of Contents


- [Introduction](#introduction)
- [Authors](#authors)
- [Table of Contents](#table-of-contents)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
  - [Quick Start](#quick-start)
- [Configuration](#configuration)
  - [Data-Volumes](#data-volumes)
  - [Environment Variables](#environment-variables)
  - [Networking](#networking)
- [Maintenance](#maintenance)
  - [Shell Access](#shell-access)
- [References](#references)

## Prerequisites

This image assumes that you are using a reverse proxy such as
[jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy) and optionally the [Let's Encrypt Proxy
Companion @
https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion](https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion)
in order to serve your pages. However, it will run just fine on it's own if you map appropriate ports. See the examples folder for a docker-compose.yml that does not rely on a reverse proxy.

You will also need an external MariaDB container

## Installation

Automated builds of the image are available on [Docker Hub](https://hub.docker.com/r/tiredofit/cachet) and is the recommended method of installation.

```bash
docker pull tiredofit/cachet
```

### Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.

* Set various [environment variables](#environment-variables) to understand the capabilities of this image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.
* Make [networking ports](#networking) available for public access if necessary

**The first boot can take from 2 minutes - 5 minutes depending on your CPU to setup the proper schemas.**

Login to the web server and enter in your admin email address, admin password and start configuring the system!

## Configuration

### Data-Volumes

The following directories are used for configuration and can be mapped for persistent storage.

| Directory                | Description                                                                                                              |
| ------------------------ | ------------------------------------------------------------------------------------------------------------------------ |
| `/www/logs`              | Nginx and PHP Log files                                                                                                  |
| `/assets/custom`         | (Optional) Copy source code over existing source code in /www/html upon container start. Use exact file/folder structure |
| `/assets/custom-scripts` | (Optional) If you want to execute custom scripting, place scripts here with extension `.sh`                              |
| `/www/html`              | (Optional) If you want to expose the cachet sourcecode and enable Self Updating, expose this volume                      |
| *OR                      |                                                                                                                          |
| `/data`                  | Hold onto your persistent sessions and cache between container restarts                                                  |

### Environment Variables

Along with the Environment Variables from the [Base image](https://hub.docker.com/r/tiredofit/alpine), and [Web Image](https://hub.docker.com/r/tiredofit/nginx), and [PHP Image](https://hub.docker.com/r/tiredofit/nginx-php-fpm) below is the complete list of available options that can be used to customize your installation.

**Still under construction, automatic installing is not fully working**

| Parameter          | Description                                                       | default               |
| ------------------ | ----------------------------------------------------------------- | --------------------- |
| `ADMIN_EMAIL`      | Administrator Email Address - Needed for logging in               | `admin@example.com`   |
| `ADMIN_PASS`       | Administrator Password - Needed for Logging in                    | `cachet`              |
| `ADMIN_USER`       | Admin username                                                    | `admin`               |
| `APPLICATION_NAME` | Change default application name - Default `cachet`                | `cachet`              |
| `APP_DEBUG`        | Debug Mode for Application                                        | `FALSE`               |
| `DB_HOST`          | Host or container name of MariaDB Server e.g. `cachet-db`         |                       |
| `DB_NAME`          | MariaDB Database name e.g. `cachet`                               |                       |
| `DB_PASS`          | MariaDB Password for above Database e.g. `password`               |                       |
| `DB_PORT`          | MariaDB Port - Default `3306`                                     | `3306`                |
| `DB_USER`          | MariaDB Username for above Database e.g. `cachet`                 |                       |
| `DRIVER_CACHE`     | Cache Driver                                                      | `apc`                 |
| `DRIVER_QUEUE`     | Queue Driver                                                      | `database`            |
| `DRIVER_SESSION`   | Session Driver                                                    | `apc`                 |
| `ENABLE_BEACON`    | Send details to cachethq.io about installation                    | `FALSE`               |
| `ENABLE_DEBUG_BAR` | Debug Bar                                                         | `FALSE`               |
| `ENABLE_EMOJI`     | Enable Github Emojis                                              | `FALSE`               |
| `MAIL_FROM_NAME`   | From Name for above address                                       | `Cachet`              |
| `MAIL_FROM`        | Mail From address                                                 | `noreply@example.com` |
| `SETUP_TYPE`       | Automatically edit configuration after first bootup `AUTO`        | `MANUAL`              | `AUTO` |
| `SITE_URL`         | The url your site listens on example `https://cachet.example.com` |                       |

### Networking

The following ports are exposed.

| Port | Description |
| ---- | ----------- |
| `80` | HTTP        |

## Maintenance

### Shell Access

For debugging and maintenance purposes you may want access the containers shell.

```bash
docker exec -it (whatever your container name is e.g. cachet) bash
```

## References

* <https://cachet.net/>

