#!/usr/bin/env bash
#
# /!\
# This script needs to be run in sudo

# ------ Requirements ------
# LUA & other base requirements check/install
apt install -y \
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
    git

if ! command -v lua >/dev/null 2>&1
then
    ln -s /usr/include/lua5.2 /usr/include/lua
    ln -s /usr/lib/x86_64-linux-gnu/liblua5.2.so /usr/local/lib/liblua.so
fi

# PHP version
if ! test "$(php --version | sed 's/[^0-9.]*\([0-9.]*\).*/\1/' | awk -F'.' ' ( $1 == 7 || ( $1 == 7 && $2 <= 1 ) || ( $1 == 7 && $2 == 1 && $3 <= 17 ) ) ' )"
then
    add-apt-repository -y ppa:ondrej/php
    apt update
    apt install -y php7.1 php7.1-mbstring
fi

# Composer
if ! command -v composer >/dev/null 2>&1
then
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
    php composer-setup.php
    php -r "unlink('composer-setup.php');"
    chmod a+x composer.phar
    mv composer.phar /usr/local/bin/composer
fi

# phpactor
if ! command -v phpactor >/dev/null 2>&1
then
    cd ~/Dev/php
    git clone git@github.com:phpactor/phpactor
    cd phpactor
    composer install
    cd /usr/local/bin
    ln -s ~/Dev/php/phpactor/bin/phpactor phpactor
    cd ~
fi

# php-cs-fixer
if ! command -v php-cs-fixer >/dev/null 2>&1
then
    wget https://cs.sensiolabs.org/download/php-cs-fixer-v2.phar -O php-cs-fixer
    chmod a+x php-cs-fixer
    mv php-cs-fixer /usr/local/bin/php-cs-fixer
fi

# Ruby
if ! test "$(ruby --version | sed 's/[^0-9.]*\([0-9.]*\).*/\1/' | awk -F'.' ' ( $1 < 2 || ( $1 == 2 && $2 < 3 ) || ( $1 == 2 && $2 == 3 && $3 <= 1 ) ) ' )"
then
    apt install -y ruby2.3
fi

# fzf
if ! ls /home/$logname/.fzf/ 2>/dev/null
then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install -y
    source ~/.bashrc
fi

# universal-ctags
if ! command -v ctags >/dev/null 2>&1
then
    git clone https://github.com/universal-ctags/ctags.git
    cd ctags
    ./autogen.sh
    ./configure
    make
    checkinstall
fi

# ------ Build ------
cd ~
if ls .vim 2>/dev/null
then
    rm -rf .vim
fi

if ls vim 2>/dev/null
then
    rm -rf vim
fi

git clone https://github.com/vim/vim
cd vim
git pull && git fetch

# In case Vim was already installed
cd src
make distclean
apt remove -y vim gvim vim-*
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
checkinstall -y

# copy config from this repo
cd ~
git clone https://github.com:Tiriel/vim-config.git
mkdir ~/.vim
cp ~/vim-config/vim.vimrc ~/.vimrc
cp ~/vim-config/dotvim/* ~/.vim/* -r
chown benjamin:benjamin -R ~/.vim
chown benjamin:benjamin ~/.vimrc
rm -rf vim-config

# install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/dikiaap/minimalist ~/.vim/bundle/minimalist

# install plugins
vim +PluginInstall +qall

