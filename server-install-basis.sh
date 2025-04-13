#!/usr/bin/env bash

sudo apt update && sudo apt update && sudo apt dist-upgrade && sudo apt install ansible

echo 'Edit nanually the file /root/.ssh/authorized_keys to allow ssh root login.'
