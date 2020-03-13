# moodle-docker: Docker Containers for Moodle Developers

This repository contains Docker configuration aimed at Moodle developers and testers to easily deploy a testing environment for Moodle.

It is a FORK of https://github.com/moodlehq/moodle-docker

## Features:

- All supported database servers (PostgreSQL, MySQL, Micosoft SQL Server, Oracle XE)
- Behat/Selenium configuration for Firefox and Chrome
- Catch-all smtp server and web interface to messages using [MailHog](https://github.com/mailhog/MailHog/)
- All PHP Extensions enabled configured for external services (e.g. solr, ldap)
- All supported PHP versions
- Zero-configuration approach
- Backed by [automated tests](https://travis-ci.org/moodlehq/moodle-docker/branches)
- Windows Batch file to download a Moodle build from Git (or refresh if already download), copy local config.docker-template.php as config.php and xcopy all files from assets/moodle_files [source](bin/setup_moodle.cmd)
- Windows Batch file to start Containers and run CLI Install of Moodle [source](bin/start_moodle.cmd)
- Windows Batch file to stop Containers [source](bin/start_moodle.cmd)

## Prerequisites

- [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose/) installed
- 3.25GB of RAM (if you choose [Microsoft SQL Server](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup#prerequisites) as db server)
- Git command line

## Windows Quick Start

From a Windows CMD prompt (not Powershell)

The following steps will clone [MOODLE_37_STABLE](https://github.com/moodle/moodle/tree/MOODLE_37_STABLE) branch, copy any files/folders in assets\moodle_files to Moodle root and start Moodle.

```bash
D:\moodle-docker> bin\setup_moodle.cmd MOODLE_37_STABLE

*** Cloning Moodle branch: MOODLE_37_STABLE

Cloning into 'D:\moodle-docker\assets\moodle_MOODLE_37_STABLE'...
remote: Enumerating objects: 24350, done.
remote: Counting objects: 100% (24350/24350), done.
remote: Compressing objects: 100% (16560/16560), done.
remote: Total 24350 (delta 5972), reused 18575 (delta 5151), pack-reused 0
Receiving objects: 100% (24350/24350), 46.81 MiB | 4.68 MiB/s, done.
Resolving deltas: 100% (5972/5972), done.
Checking out files: 100% (18947/18947), done.


*** Ensure customized config.php for the Docker containers is in place

        1 file(s) copied.


*** Ensure moodle files from D:\moodle-docker\assets\moodle_files\ are installed

D:\moodle-docker\assets\moodle_files\moodle_channels.csv
1 File(s) copied


D:\moodle-docker>bin\start_moodle.cmd

*** Bring up the Docker containers

WARNING: The MOODLE_DOCKER_SELENIUM_SUFFIX variable is not set. Defaulting to a blank string.
Creating network "moodle-docker_default" with the default driver
Creating moodle-docker_db_1       ... done
Creating moodle-docker_exttests_1 ... done
Creating moodle-docker_selenium_1  ... done
Creating moodle-docker_mailhog_1  ... done
Creating moodle-docker_webserver_1 ... done


*** Run the Moodle CLI script: admin/cli/install_database.php

-------------------------------------------------------------------------------
== Setting up database ==
-->System
++ Success ++
-->antivirus_clamav
++ Success ++
-->availability_completion
++ Success ++
...
...
-->logstore_legacy
++ Success ++
-->logstore_standard
++ Success ++
Installation completed successfully.


*** Moodle is running please. Browse to - http://127.0.0.1:8000
*** Moodle Admin Username: admin
*** Moodle Admin password: test

D:\moodle-docker>
```

## Environment variables

You can change the configuration of the docker images by setting various environment variables before calling `bin/moodle-docker-compose up`.

| Environment Variable                      | Mandatory | Allowed values                         | Default value  | Notes                                                                                                                                                                                                            |
| ----------------------------------------- | --------- | -------------------------------------- | -------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `MOODLE_DOCKER_DB`                        | yes       | pgsql, mariadb, mysql, mssql, oracle   | none           | The database server to run against                                                                                                                                                                               |
| `MOODLE_DOCKER_WWWROOT`                   | yes       | path on your file system               | none           | The path to the Moodle codebase you intend to test                                                                                                                                                               |
| `MOODLE_DOCKER_PHP_VERSION`               | no        | 7.4, 7.3, 7.2, 7.1, 7.0, 5.6           | 7.2            | The php version to use                                                                                                                                                                                           |
| `MOODLE_DOCKER_BROWSER`                   | no        | firefox, chrome                        | firefox        | The browser to run Behat against                                                                                                                                                                                 |
| `MOODLE_DOCKER_PHPUNIT_EXTERNAL_SERVICES` | no        | any value                              | not set        | If set, dependencies for memcached, redis, solr, and openldap are added                                                                                                                                          |
| `MOODLE_DOCKER_WEB_HOST`                  | no        | any valid hostname                     | localhost      | The hostname for web                                                                                                                                                                                             |
| `MOODLE_DOCKER_WEB_PORT`                  | no        | any integer value (or bind_ip:integer) | 127.0.0.1:8000 | The port number for web. If set to 0, no port is used.<br/>If you want to bind to any host IP different from the default 127.0.0.1, you can specify it with the bind_ip:port format (0.0.0.0 means bind to all)  |
| `MOODLE_DOCKER_SELENIUM_VNC_PORT`         | no        | any integer value (or bind_ip:integer) | not set        | If set, the selenium node will expose a vnc session on the port specified. Similar to MOODLE_DOCKER_WEB_PORT, you can optionally define the host IP to bind to. If you just set the port, VNC binds to 127.0.0.1 |

## Advanced usage

As can be seen in [bin/moodle-docker-compose](https://github.com/moodlehq/moodle-docker/blob/master/bin/moodle-docker-compose),
this repo is just a series of docker-compose configurations and light wrapper which make use of companion docker images. Each part
is designed to be reusable and you are encouraged to use the docker[-compose] commands as needed.

## Companion docker images

The following Moodle customised docker images are close companions of this project:

- [moodle-php-apache](https://github.com/moodlehq/moodle-php-apache): Apache/PHP Environment preconfigured for all Moodle environments
- [moodle-db-mssql](https://github.com/moodlehq/moodle-db-mssql): Microsoft SQL Server for Linux configured for Moodle
- [moodle-db-oracle](https://github.com/moodlehq/moodle-db-oracle): Oracle XE configured for Moodle

## Contributions

Are extremely welcome!
