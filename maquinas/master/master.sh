sudo yum remove python3 -y
sudo yum install python3.9 -y
python3 -m pip install --user ansible
sudo yum install git -y

sudo dnf -y update && sudo dnf -y upgrade

sudo dnf -y install vim

sudo sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config;
sudo systemctl restart sshd;

echo "root:toor" | sudo chpasswd
echo "PS1='\e[1;32m\u@\h\e[m \e[1;36m\w $ \e[m'" | sudo tee -a /etc/bashrc
echo "PS1='\e[0;31m\u@\h\e[m \e[1;36m\w\e[m\e[0;31m # \e[m'" | sudo tee -a /root/.bashrc
source .bashrc