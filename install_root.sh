#!/bin/bash
# docker-camisole/install_root.sh

# Update container
apt-get update -y
apt-get upgrade -y

# Set container to unicode (important for Java)
apt-get install -y locales
#apt-get install -y locales-all
#rm -rf /var/lib/apt/lists/*
sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
#echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen --purge en_US.UTF-8
#dpkg-reconfigure --frontend=noninteractive locales
#localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
#echo -e 'LANG="en_US.UTF-8"\nLANGUAGE="en_US:en"\n' > /etc/default/locale
#echo "LC_ALL=en_US.UTF-8" >> /etc/environment
#echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
#echo "LANG=en_US.UTF-8" > /etc/locale.conf
#update-locale LANG=en_US.UTF-8
#update-locale LC_ALL=en_US.UTF-8
#export LANG="en_US.UTF-8"
#export LANGUAGE="en_US:en"
#export LC_CTYPE="en_US.UTF-8"
#export LC_NUMERIC="en_US.UTF-8"
#export LC_TIME="en_US.UTF-8"
#export LC_COLLATE="en_US.UTF-8"
#export LC_MONETARY="en_US.UTF-8"
#export LC_MESSAGES="en_US.UTF-8"
#export LC_PAPER="en_US.UTF-8"
#export LC_NAME="en_US.UTF-8"
#export LC_ADDRESS="en_US.UTF-8"
#export LC_TELEPHONE="en_US.UTF-8"
#export LC_MEASUREMENT="en_US.UTF-8"
#export LC_IDENTIFICATION="en_US.UTF-8"
#export LC_ALL="en_US.UTF-8"

# Install linux headers and compilers
#apt-get install -y --assume-yes --no-install-recommends apt-utils
apt-get install -y apt-utils
apt-get install -y apt-transport-https
apt-get install -y build-essential
apt-get install -y libcap-dev

# Install basic tools
apt-get install -y sudo
apt-get install -y curl
apt-get install -y wget

# Install language : Ada		gnatmake
apt-get install -y gnat

# Install language : C			gcc
apt-get install -y gcc

# Install language : C++		g++
apt-get install -y g++

# Install language : C# 		mono	mcs
apt-get install -y mono-runtime
apt-get install -y mono-mcs

# Install language : D			dmd
# `snap` doesn't work inside a container
#apt-get install -y snapd
#systemctl unmask snapd.service
#systemctl enable snapd.service
#systemctl start snapd.service
#service snapd start
#snap install core
#snap install --classic dmd
#snap install --classic dub
#snap install --classic ldc2
# Let's install D bareback-style
wget https://sourceforge.net/projects/d-apt/files/d-apt.list/download -O /etc/apt/sources.list.d/d-apt.list
apt-get update --allow-insecure-repositories
apt-get -y --allow-unauthenticated install --reinstall d-apt-keyring
apt-get update
apt-get install -y dmd-compiler dub

# Install language : Go			go
apt-get install -y golang-go

# Install language : Haskell	ghc
apt-get install -y ghc-dynamic
ghc-pkg check
ghc-pkg recache

# Install language : Java		javap	java	javac
# (the `mkdir` is a trick for the installer on man-less aka `slim` containers)
mkdir -p /usr/share/man/man1
apt-get install -y openjdk-11-jdk-headless

# Install language : Javascript	node
apt-get install -y nodejs

# Install language : Lua		lua
apt-get install -y lua5.3

# Install language : OCaml		ocamlopt
apt-get install -y ocaml-nox

# Install language : PHP		php
apt-get install -y php-cli

# Install language : Pascal		fpc
apt-get install -y fp-compiler

# Install language : Perl		perl
apt-get install -y perl

# Install language : Prolog		swipl
apt-get install -y swi-prolog-nox

# Install language : Python		python3
apt-get install -y python3
apt-get install -y python3-pip
apt-get install -y python3-setuptools
# (the following lines updates python modules even further)
python3 -m pip install -U pip
python3 -m pip install -U setuptools
python3 -m pip install -U aiohttp
python3 -m pip install -U msgpack
python3 -m pip install -U pyyaml
python3 -m pip install -U wheel

# Install language : Ruby		ruby
apt-get install -y ruby

# Install language : Rust		rustc
apt-get install -y rustc

# Install language : Scheme		gsi
apt-get install -y gambc

# Install git
apt-get install -y git

# Install `isolate`
pushd /tmp
git clone https://github.com/ioi/isolate.git
pushd isolate
make PREFIX="/usr" VARPREFIX="/var" CONFIGDIR="/etc" isolate
make PREFIX="/usr" VARPREFIX="/var" CONFIGDIR="/etc" install
popd
popd
sed -i "s|/var/local/lib/isolate|/var/lib/isolate|" /etc/isolate
groupadd isolate
usermod -aG isolate mcmurphy
chown -v root:isolate /usr/bin/isolate
chmod -v u+s /usr/bin/isolate

# Install `camisole`
pushd /tmp
git clone https://github.com/prologin/camisole.git
pushd camisole
python3 setup.py build
python3 setup.py install
popd
popd

# Clean-up things
apt-get install -y --fix-broken
apt-get clean
#rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
