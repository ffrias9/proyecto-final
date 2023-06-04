#!/bin/bash

sudo yum remove python3 python36 ansible -y

python3 -m pip uninstall ansible -y

sudo yum install python39 -y

python3 -m pip install --user ansible
