# nfs_server_config Module
[![Build Status](https://travis-ci.org/Adaptavist/puppet-nfs_server_config.svg?branch=master)](https://travis-ci.org/Adaptavist/puppet-nfs_server_config)

## Overview

The **puppet-nfs_server_exports** module deals with adding exports into the system exports file (/etc/exports)

## Configuration

`nfs_server_exports::exports`

Hash of export lines to add, defaults to *undef*

`nfs_server_exports::exports_path`

Path to the system exports file, defaults to */etc/exports*

`nfs_server_exports::refresh_exports_cmd`

Command to run to refresh exports after adding to file, defaults to *exportfs -ra*