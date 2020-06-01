# nfs_server_config Module
[![Build Status](https://travis-ci.org/Adaptavist/puppet-nfs_server_exports.svg?branch=master)](https://travis-ci.org/Adaptavist/puppet-nfs_server_exports)
## Overview

The **puppet-nfs_server_exports** module deals with adding exports into the system exports file (/etc/exports), it is designed to extend the functionality of the **ghoneycutt/puppet-module-nfs** modules, it is *NOT* designed to be run as standalone

## Configuration

`nfs_server_exports::exports`

Hash of export lines to add, defaults to *undef*

`nfs_server_exports::exports_path`

Path to the system exports file, defaults to the value of the `exports_path` from the parent NFS module

`nfs_server_exports::refresh_exports_exec`

The exec that refrehes the exports, defaults to *update_nfs_exports*, which runs in the parent NFS module

``nfs_server_exports::manage_all_exports`

Flag to determine if this module manages *ALL* exports, if true the exports file will be cleared before any other action, defaults to *true*