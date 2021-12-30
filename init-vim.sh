#!/usr/bin/env bash

Help(){
    echo "Syntax: $0 [-i|c|h]"
    echo "Must run with normal permission!!"
    echo "Options:"
    echo "i     install more plugins"
    echo "c     replace the file config"
    echo "h     for help"
}

Install(){
    sudo apt-get install vim-gtk3 -y
    echo "Install Done"
    echo "#########################"
    echo "Installing vim-plug for manager plugin..."
}

Config(){
    #init file config
    config=~/.vimrc
    rm $config
    cp ./config_files/.vimrc $config
    echo 'Config Done !!'
    echo "#########################"
}

#get option:
while getopts ":hic" option; do
    case "${option}" in
        i)
            Install
            ;;
        c)
            Config
            ;;
        h)
            Help 
            ;;
    esac
done
