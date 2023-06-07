sudo apt-get -y update && sudo apt-get -y upgrade

sudo apt-get -y install vim

sudo sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config;
sudo systemctl restart sshd;

echo "root:toor" | sudo chpasswd
echo "vagrant:vagrant" | sudo chpasswd
echo "PS1='\e[1;32m\u@\h:\e[m \e[1;36m\w\$ \e[m'" | sudo tee -a /etc/bashrc
source .bashrc