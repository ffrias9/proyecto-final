sudo sed -i -e "s|mirrorlist=|#mirrorlist=|g" /etc/yum.repos.d/CentOS-*
sudo sed -i -e "s|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g" /etc/yum.repos.d/CentOS-*

sudo dnf clean all
sudo dnf -y swap centos-linux-repos centos-stream-repos

sudo dnf -y update && sudo dnf -y upgrade

sudo dnf makecache
sudo dnf -y install epel-release
sudo dnf makecache
sudo dnf -y install vim

sudo sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config;
sudo systemctl restart sshd;

echo "root:toor" | sudo chpasswd
echo "PS1='\e[1;32m\u@\h:\e[m \e[1;36m\w\$ \e[m'" | sudo tee -a /etc/bashrc
source .bashrc