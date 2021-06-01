#!/usr/bin/env bash

Help(){
    echo "Syntax: $0 [-i|c|h]"
    echo "Options:"
    echo "i     install more plugins"
    echo "c     only replace the file config"
    echo "h     for help"
}

Install(){
    sudo apt-get install vim-gtk3 -y
    echo "Install Done"
    echo "#########################"
}

Config(){
    #init file config
    config=~/.vimrc
    rm $config
    touch $config
    #init tab leght
    echo 'set tabstop=4       " The width of a TAB is set to 4.
                        " Still it is a \t. It is just that
                        " Vim will interpret it to be having
                        " a width of 4.
    set shiftwidth=4    " Indents will have a width of 4.
    set softtabstop=4   " Sets the number of columns for a TAB.
    set expandtab       " Expand TABs to spaces.' >> $config 
    echo 'syntax on' >> $config #init syntax highlight
    echo 'set number relativenumber' >> $config #init line number
    echo 'set clipboard+=unnamed,unnamedplus' >> $config #init the clipboard for copy-parse with terminal
    echo 'set hlsearch' >> $config #init hightlight the search
    
    
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
