# Mydumper - An utility to dump MySQL databases

[![GitHub license](https://img.shields.io/github/license/n-rodriguez/mydumper.svg)](https://github.com/n-rodriguez/mydumper/blob/master/LICENSE)
[![Build Status](https://github.com/n-rodriguez/mydumper/workflows/Github%20CI/badge.svg?branch=master)](https://github.com/n-rodriguez/mydumper/actions)

Mydumper is an utility to dump MySQL databases written in [Crystal](https://crystal-lang.org/).

## Installation

TODO: Write installation instructions here

## Usage

```sh
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8: ### START DB BACKUP | localhost/daily/deploy_it/1614257137 ###
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8: Mydumper::Runtime::Middleware::CreateDirectories
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Creating directory: /home/nicolas/test-backup/localhost/daily/deploy_it
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Directory created: /home/nicolas/test-backup/localhost/daily/deploy_it
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Creating directory: /home/nicolas/test-backup/localhost/daily/deploy_it/tables
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Directory created: /home/nicolas/test-backup/localhost/daily/deploy_it/tables
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8: Mydumper::Runtime::Middleware::CreateCredentialsFile
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Creating file: /home/nicolas/test-backup/localhost/daily/deploy_it/credentials.cnf
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * File created: /home/nicolas/test-backup/localhost/daily/deploy_it/credentials.cnf
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8: Mydumper::Runtime::Middleware::DumpGlobalSchema
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping database schema: /home/nicolas/test-backup/localhost/daily/deploy_it/global.schema.sql
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Database schema dumped: /home/nicolas/test-backup/localhost/daily/deploy_it/global.schema.sql
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8: Mydumper::Runtime::Middleware::DumpTablesSchema
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.application_addons
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.application_credentials
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.application_databases
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.application_types
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.application_credentials
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.application_addons
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.application_databases
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.application_types
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.applications
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.ar_internal_metadata
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.buildpacks
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.builds
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.ar_internal_metadata
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.applications
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.buildpacks
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.builds
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.configs
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.container_events
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.containers
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.docker_images
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.configs
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.containers
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.container_events
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.docker_images
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.domain_names
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.env_vars
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.groups
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.groups_users
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.domain_names
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.env_vars
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.groups
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.groups_users
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.locks
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.member_roles
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.members
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.mount_points
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.locks
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.members
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.member_roles
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.mount_points
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.platform_credentials
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.platforms
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.pushes
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.releases
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.platform_credentials
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.platforms
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.pushes
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.releases
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.repositories
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.repository_credentials
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.reserved_names
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.roles
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.repositories
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.repository_credentials
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.roles
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.reserved_names
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.schema_migrations
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.server_roles
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.servers
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.ssh_public_keys
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.server_roles
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.schema_migrations
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.servers
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.ssh_public_keys
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.ssl_certificates
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.stages
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table schema: deploy_it.users
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.stages
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.ssl_certificates
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table schema dumped: deploy_it.users
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8: Mydumper::Runtime::Middleware::DumpTablesData
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.application_addons
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.application_credentials
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.application_databases
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.application_types
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.application_databases
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.application_addons
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.application_credentials
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.application_types
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.applications
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.ar_internal_metadata
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.buildpacks
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.builds
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.ar_internal_metadata
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.applications
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.buildpacks
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.builds
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.configs
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.container_events
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.containers
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.docker_images
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.configs
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.container_events
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.containers
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.docker_images
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.domain_names
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.env_vars
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.groups
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.groups_users
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.env_vars
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.groups
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.domain_names
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.groups_users
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.locks
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.member_roles
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.members
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.mount_points
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.member_roles
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.locks
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.members
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.mount_points
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.platform_credentials
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.platforms
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.pushes
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.releases
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.platforms
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.platform_credentials
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.pushes
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.releases
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.repositories
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.repository_credentials
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.reserved_names
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.roles
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.repository_credentials
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.repositories
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.reserved_names
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.roles
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.schema_migrations
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.server_roles
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.servers
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.ssh_public_keys
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.schema_migrations
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.server_roles
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.servers
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.ssh_public_keys
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.ssl_certificates
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.stages
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Dumping table data: deploy_it.users
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.ssl_certificates
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.stages
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Table data dumped: deploy_it.users
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8: Mydumper::Runtime::Middleware::CleanCredentialsFile
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Deleting file: /home/nicolas/test-backup/localhost/daily/deploy_it/credentials.cnf
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * File deleted: /home/nicolas/test-backup/localhost/daily/deploy_it/credentials.cnf
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8: Mydumper::Runtime::Middleware::CreateRestoreScript
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Creating file: /home/nicolas/test-backup/localhost/daily/deploy_it/restore.sh
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * File created: /home/nicolas/test-backup/localhost/daily/deploy_it/restore.sh
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8: Mydumper::Runtime::Middleware::CreateArchive
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Creating tar archive: /home/nicolas/test-backup/localhost/daily/deploy_it.2021-02-25_13h45.Thursday.tar.gz
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Tar archive created: /home/nicolas/test-backup/localhost/daily/deploy_it.2021-02-25_13h45.Thursday.tar.gz
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8: Mydumper::Runtime::Middleware::CleanDirectories
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Deleting directory: /home/nicolas/test-backup/localhost/daily/deploy_it
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8:  * Directory deleted: /home/nicolas/test-backup/localhost/daily/deploy_it
I, [2021-02-25T12:45:37Z #1056848]    INFO -- TID-1dt3viacu8: ### END DB BACKUP | localhost/daily/deploy_it/1614257137 ###
```

## Development

TODO: Write development instructions here
