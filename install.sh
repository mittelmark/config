#!/bin/bash

SCRIPT_DIR=$(dirname "$0")
cp -r ${SCRIPT_DIR}/.config/jasspa ~/.config/
/bin/sh -c "$(curl -fsSL https://github.com/bjasspa/jasspa/releases/latest/download/microemacs-install)"
if [[ `which cppcheck` == "" ]]; then 
    pip3 install cppcheck --user
fi
if [[ `which cpplint` == "" ]]; then 
    pip3 install cpplint --user
fi
if [[ `which astyle` == "" ]]; then 
    pip3 install astyle --user
fi

function install-fonts {
    if [[ -z $1 ]]; then
        DIR=~/.local/share/fonts
    else
        DIR=$1
    fi
    [[ -d $DIR ]] || mkdir -p $DIR
    find /usr -iname "*Mono*.ttf" 2>/dev/null | xargs ln -sf -t ${DIR}
    if [[ ! -f ${DIR}/ubuntu-mono-bold.ttf ]]; then
        wget -q https://github.com/braver/programmingfonts/raw/gh-pages/fonts/resources/ubuntu/ubuntu-bold.ttf -O ${DIR}/ubuntu-mono-bold.ttf
        wget -q https://github.com/braver/programmingfonts/raw/gh-pages/fonts/resources/ubuntu/ubuntu.ttf    -O ${DIR}/ubuntu-mono-medium.ttf    
        wget -q https://github.com/braver/programmingfonts/raw/gh-pages/fonts/resources/ubuntu/license.txt -O ${DIR}/ubuntu-license.txt    
    fi  
    if [[ ! -f ${DIR}/source-code-pro-medium.ttf ]]; then 
        wget -q https://github.com/adobe-fonts/source-code-pro/raw/release/LICENSE.md -O ${DIR}/source-code-pro-license.txt
	wget -q https://github.com/adobe-fonts/source-code-pro/raw/release/TTF/SourceCodePro-Bold.ttf -O ${DIR}/source-code-pro-bold.ttf
	wget -q https://github.com/adobe-fonts/source-code-pro/raw/release/TTF/SourceCodePro-Regular.ttf -O ${DIR}/source-code-pro-medium.ttf     
    fi	
    if [[ ! -f ${DIR}/courier-prime-medium.ttf ]]; then 
        wget -q https://github.com/quoteunquoteapps/CourierPrime/raw/master/fonts/ttf/CourierPrime-Regular.ttf -O ${DIR}/courier-prime-medium.ttf
	wget -q https://github.com/quoteunquoteapps/CourierPrime/raw/master/fonts/ttf/CourierPrime-Bold.ttf -O ${DIR}/courier-prime-bold.ttf
	wget -q https://github.com/quoteunquoteapps/CourierPrime/blob/master/OFL.txt -O ${DIR}/courier-prime-license.txt
    fi
    mkfontscale $DIR
    mkfontdir $DIR
    xset +fp $DIR
    xset fp rehash
}   
install-fonts 
alias mfontsel2="xfontsel -pattern '-*-m-*-' -scale"
