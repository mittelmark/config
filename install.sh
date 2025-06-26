#!/bin/bash

SCRIPT_DIR=$(dirname "$0")
cp -r ${SCRIPT_DIR}/.config/jasspa ~/.config/
/bin/sh -c "$(curl -fsSL https://github.com/bjasspa/jasspa/releases/latest/download/microemacs-install)"
cat bashrc.sh >> ~/.bashrc
function install-fonts {
    if [[ -z $1 ]]; then
        DIR=~/.local/share/fonts
    else
        DIR=$1
    fi
    [[ -d $DIR ]] || mkdir -p $DIR
    echo "linking local fonts into $DIR"
    find /usr -iname "*Mono*.ttf" 2>/dev/null | xargs ln -sf -t ${DIR}
    if [[ ! -f ${DIR}/ubuntu-mono-bold.ttf ]]; then
        echo "installing Ubuntu fonts ..."
        wget -q https://github.com/braver/programmingfonts/raw/gh-pages/fonts/resources/ubuntu/ubuntu-bold.ttf -O ${DIR}/ubuntu-mono-bold.ttf
        wget -q https://github.com/braver/programmingfonts/raw/gh-pages/fonts/resources/ubuntu/ubuntu.ttf    -O ${DIR}/ubuntu-mono-medium.ttf    
        wget -q https://github.com/braver/programmingfonts/raw/gh-pages/fonts/resources/ubuntu/license.txt -O ${DIR}/ubuntu-license.txt    
    fi  
    if [[ ! -f ${DIR}/source-code-pro-medium.ttf ]]; then 
        echo "installing Source Code Pro fonts ..."
        wget -q https://github.com/adobe-fonts/source-code-pro/raw/release/LICENSE.md -O ${DIR}/source-code-pro-license.txt
	wget -q https://github.com/adobe-fonts/source-code-pro/raw/release/TTF/SourceCodePro-Bold.ttf -O ${DIR}/source-code-pro-bold.ttf
	wget -q https://github.com/adobe-fonts/source-code-pro/raw/release/TTF/SourceCodePro-Regular.ttf -O ${DIR}/source-code-pro-medium.ttf     
    fi	
    if [[ ! -f ${DIR}/courier-prime-medium.ttf ]]; then 
        echo "installing Courier Prime fonts ..."
        wget -q https://github.com/quoteunquoteapps/CourierPrime/raw/master/fonts/ttf/CourierPrime-Regular.ttf -O ${DIR}/courier-prime-medium.ttf
	wget -q https://github.com/quoteunquoteapps/CourierPrime/raw/master/fonts/ttf/CourierPrime-Bold.ttf -O ${DIR}/courier-prime-bold.ttf
	wget -q https://github.com/quoteunquoteapps/CourierPrime/blob/master/OFL.txt -O ${DIR}/courier-prime-license.txt
    fi
    mkfontscale $DIR
    mkfontdir $DIR
    xset +fp $DIR
    xset fp rehash
    echo "Fonts installed!"
}   

function install-tmux {
    wget -q https://github.com/nelsonenzo/tmux-appimage/releases/download/3.3a/tmux.appimage -O ~/.local/bin/tmux
    chmod 755 ~/.local/bin/tmux
    echo "tmux installed ~/.local/bin"
}
function install-bat {
    wget -q https://github.com/sharkdp/bat/releases/download/v0.25.0/bat-v0.25.0-x86_64-unknown-linux-gnu.tar.gz
    tar xfvz bat-v0.25.0-x86_64-unknown-linux-gnu.tar.gz
    cp bat-v0.25.0-x86_64-unknown-linux-gnu/bat ~/.local/bin/
    chmod 755 ~/.local/bin/bat
    [[ -d ~/.local/man ]] || mkdir -p ~/.local/man
    cp bat-v0.25.0-x86_64-unknown-linux-gnu/bat.1 ~/.local/man/
    rm -rf bat-v0.25.0-x86_64-unknown-linux-gnu*
    echo "bat installed  into ~/.local/bin"
}
install-fonts 

install-tmux

install-bat

