#!/bin/bash

# Ensure script runs with elevation
if [[ $(id -u) -ne 0 ]]; then echo "[ ERROR ] - Please run as root!"; exit 1; fi

# Set hostname
hostname "flask-webserver"

# Install dependencies
apt update -y && apt install -y python3-pip
