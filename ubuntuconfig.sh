#! /bin/bash
 
# change apt sources list
cp /etc/apt/sources.list /etc/apt/sources.list.bak
sed -i "s/cn.archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list
apt update 


# install softwares

apt install net-tools tmux vim zsh git ssh -y




# change config file 
sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config

# restart service
service ssh restart


# oh-my-zsh
wget http://129.226.182.204/install.sh -O - | sh;chsh -s /bin/zsh 
su - test -c "wget http://129.226.182.204/install.sh -O - | sh;chsh -s /bin/zsh "

# oh-my-tmux
cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

# install docker 

read -p "install docker?[y/n](default n):" dockerflag

if [ "n" = "$dockerflag" -o "" = "$dockerflag" ]; then  
  echo "skip install docker"  
else  
    apt install docker.io docker-compose
fi 

# install jenv




