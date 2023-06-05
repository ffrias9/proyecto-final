#!/bin/bash

sudo yum remove python3 python36 ansible -y

python3 -m pip uninstall ansible -y

sudo yum install python39 python39-pip -y

python3 -m pip install --user ansible

python3 -m pip install --user molecule[docker]

pip3 install --upgrade selinux
