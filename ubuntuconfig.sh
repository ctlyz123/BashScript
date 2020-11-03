#! /bin/bash
 
# change apt sources list
cp /etc/apt/sources.list /etc/apt/sources.list.bak

version=`cat /etc/issue| head -n 1 | awk '{print $2}' | awk -F '.' '{print $1"."$2}'`

if [ "$version" = "20.04" ]; then
	sed -i "s/cn.archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list
fi

if [ "$version" = "16.04" ]; then
	sed -i "s/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list
fi
	apt update 


# install softwares

apt install net-tools tmux vim zsh git ssh python curl zip -y

# change config file 
sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config

# restart service
service ssh restart


# oh-my-zsh
wget https://raw.githubusercontent.com/ctlyz123/BashScript/master/zsh/install.sh  -O - | sh;chsh -s /bin/zsh 
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
su - test -c "wget https://raw.githubusercontent.com/ctlyz123/BashScript/master/zsh/install.sh -O - | sh;chsh -s /bin/zsh;git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions;source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"

# autojump
cd /home/
git clone https://github.com/ctlyz123/autojump.git
cd autojump
./install.py
echo '[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && . ~/.autojump/etc/profile.d/autojump.sh' >> ~/.zshrc

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

read -p "install jenv?[y/n](default n):" jenvflag

if [ "n" = "$jenvflag" -o "" = "$jenvflag" ]; then  
  echo "skip install docker"  
else  
	git clone https://github.com/ctlyz123/jenv.git ~/.jenv
	echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.zshrc
	echo 'eval "$(jenv init -)"' >> ~/.zshrc
fi 







