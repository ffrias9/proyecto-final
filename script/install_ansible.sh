#!/bin/bash

sudo yum remove python3 -y

sudo yum install python3.9 -y

python3 -m pip install --user ansible
