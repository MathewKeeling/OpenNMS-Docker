# Docker\OpenNMS: Install Guide

## Introduction

This is a set of scripts and tools to install and manage an OpenNMS instance installed via docker.

## Installation

1. Customize your installer by modifying the contents of 
```
/opt/depot/installers/OPENNMS/main/install-docker-openns0-localization.sh
```

2. Perform the Minion customization as instructed at the end of the installer. Record the credentials you provided.

3. After installation is completed, start the OpenNMS core container

You have successfully installed OpenNMS using Docker.

## Directories

```
conf
    This directory contains all of the configuration files necessary for a base installation.
conf/core
    These are the base install files:
        YAML files
        Properties
        XML
conf/etc
    Customization files
        User accounts
conf/minion
    YAML

script
    This directory includes scripts that are used to manage your Docker\OpenNMS instance
```