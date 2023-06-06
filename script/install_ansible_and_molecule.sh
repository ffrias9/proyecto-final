#!/bin/bash

echo "Remove Ansible if is it install..."
python3 -m pip uninstall ansible -y > /dev/null

echo "Removing old versions of Python..."
sudo yum remove python3 python36 ansible -y > /dev/null

echo "Installing Python3.9 and pip..."
sudo yum install python39 python39-pip -y > /dev/null

echo "Installing Ansible..."
python3 -m pip install ansible --user > /dev/null

echo "Installing Molecule-3.4..."
pip install molecule==3.4.0 > /dev/null

echo "Installing Molecule[docker]..."
pip install molecule[docker]==3.4.0 > /dev/null

echo "Installing Ansible-lint-5.1.1..."
pip install ansible-lint==5.1.1 > /dev/null

echo "Deactivating SELinux..."
sudo setenforce 0 > /dev/null
