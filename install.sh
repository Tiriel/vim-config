#!/usr/bin/env bash
#
# /!\
# This script needs to be run in sudo
if [ "$1" = "" ]
then
    printf "\n\
\e[0;37;41m                                                         \e[0m\n\
\e[0;37;41m    This script needs to be passed the sudo password.    \e[0m\n\
\e[0;37;41m                                                         \e[0m\n\
\n"
    return
fi
DIR=$(cd `dirname $0` && pwd)

# Starting by removing all other versions of vim
echo $1 | sudo -S apt remove -y vim vim*
echo $1 | sudo -S apt autoremove

# ------ Requirements ------
# LUA & other base requirements check/install
echo $1 | sudo -S apt install -y \
    libncurses5-dev \
    libgnome2-dev \
    libgnomeui-dev \
    libgtk2.0-dev \
    libatk1.0-dev \
    libbonoboui2-dev \
    libcairo2-dev \
    libx11-dev \
    libxpm-dev \
    libxt-dev \
    python-dev \
    python3-dev \
    ruby-dev \
    lua5.2 \
    liblua5.2-dev \
    luajit \
    libperl-dev \
    checkinstall \
    autotools-dev \
    autoconf \
    fonts-powerline \
    git

if ! command -v lua >/dev/null 2>&1
then
    echo $1 | sudo -S ln -s /usr/include/lua5.2 /usr/include/lua
    echo $1 | sudo -S ln -s /usr/lib/x86_64-linux-gnu/liblua5.2.so /usr/local/lib/liblua.so
fi

# PHP version
if ! test "$(php --version | sed 's/[^0-9.]*\([0-9.]*\).*/\1/' | awk -F'.' ' ( $1 == 7 || ( $1 == 7 && $2 <= 1 ) || ( $1 == 7 && $2 == 1 && $3 <= 17 ) ) ' )"
then
    echo $1 | sudo -S add-apt-repository -y ppa:ondrej/php
    echo $1 | sudo -S apt update
    echo $1 | sudo -S apt install -y php7.1 php7.1-mbstring
fi

# Composer
if ! command -v composer >/dev/null 2>&1
then
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
    php composer-setup.php
    php -r "unlink('composer-setup.php');"
    chmod a+x composer.phar
    echo $1 | sudo -S mv composer.phar /usr/local/bin/composer
fi

# phpactor
if ! command -v phpactor >/dev/null 2>&1
then
    cd /home/$(logname)/Dev/php
    git clone https://github.com/phpactor/phpactor.git
    cd phpactor
    composer install
    echo $1 | sudo -S cd /usr/local/bin
    echo $1 | sudo -S ln -s /home/$(logname)/Dev/php/phpactor/bin/phpactor phpactor
    cd /home/$(logname)/
fi

# php-cs-fixer
if ! command -v php-cs-fixer >/dev/null 2>&1
then
    wget https://cs.sensiolabs.org/download/php-cs-fixer-v2.phar -O php-cs-fixer
    chmod a+x php-cs-fixer
    echo $1 | sudo -S mv php-cs-fixer /usr/local/bin/php-cs-fixer
fi

# Ruby
if ! test "$(ruby --version | sed 's/[^0-9.]*\([0-9.]*\).*/\1/' | awk -F'.' ' ( $1 < 2 || ( $1 == 2 && $2 < 3 ) || ( $1 == 2 && $2 == 3 && $3 <= 1 ) ) ' )"
then
    echo $1 | sudo -S apt install -y ruby2.3
fi

# fzf
if ! eval ls "/home/$(logname)/.fzf" >/dev/null 2>&1
then
    git clone --depth 1 https://github.com/junegunn/fzf.git /home/$(logname)/.fzf
    yes | /home/$(logname)/.fzf/install
    source /home/$(logname)/.bashrc
fi

# universal-ctags
if ! command -v ctags >/dev/null 2>&1
then
    git clone https://github.com/universal-ctags/ctags.git
    cd ctags
    ./autogen.sh
    ./configure
    make
    echo $1 | sudo -S checkinstall
    cd ..
    echo $1 | sudo -S rm -rf ctags
fi

# ------ Build ------
cd /home/$(logname)/
if ls .vim 2>/dev/null
then
    echo $1 | rm -rf .vim
fi

if ls vim 2>/dev/null
then
    echo $1 | sudo -S rm -rf vim
fi

git clone https://github.com/vim/vim
cd vim
git pull && git fetch

# In case Vim was already installed
cd src
echo $1 | sudo -S make distclean
echo $1 | sudo -S apt remove -y vim gvim vim-*
cd ..

./configure \
--enable-luainterp=yes \
--enable-perlinterp=yes \
--enable-pythoninterp=yes \
--enable-rubyinterp=yes \
--enable-cscope \
--disable-netbeans \
--enable-multibyte \
--enable-largefile \
--enable-gui=no \
--with-features=huge \
--with-ruby-command=/usr/bin/ruby \
--with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
--enable-python3interp \
--with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \
--with-luajit \
--with-x \
--enable-fontset \
--enable-largefile \
--with-compiledby="Benjamin Zaslavsky" \
--enable-fail-if-missing

make
echo $1 | sudo -S checkinstall -y

# copy config from this repo
cd /home/$(logname)/
cp $DIR/vim.vimrc /home/$(logname)/.vimrc
cp $DIR/dotvim /home/$(logname)/.vim -r
cp $DIR/MySnips /home/$(logname)/.vim/MySnips -r

# install Vundle
echo $1 | sudo -S rm -fr /home/$(logname)/.vim/bundle/Vundle*
echo $1 | sudo -S rm -fr /home/$(logname)/.vim/bundle/sublime*
git clone https://github.com/VundleVim/Vundle.vim.git /home/$(logname)/.vim/bundle/Vundle.vim
git clone git@github.com:Tiriel/sublimemonokai /home/$(logname)/.vim/bundle/sublimemonokai

# install plugins
vim +PluginInstall +qall

cd /home/$(logname)/.vim/bundle/phpactor
composer install

chown $(logname):$(logname) -R /home/$(logname)/.vim
chown $(logname):$(logname) /home/$(logname)/.vimrc

cd /home/$(logname)/

printf "\n\
\e[0;37;42m                                 \e[0m\n\
\e[0;37;42m            All done!            \e[0m\n\
\e[0;37;42m                                 \e[0m\n\
\n"

