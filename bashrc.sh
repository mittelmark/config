#!/bin/bash
alias mfontsel="xfontsel -pattern '*-m-*' -scale"
alias curl-cheat="curl cheat.sh"
export PATH=~/.local/bin:$PATH
function backup-cpp {
    cd ~
    zip -yr backup-cpp-`date +%Y-%m-%d`.zip .config/jasspa .local/bin .local/share/jasspa \
        .local/share/fonts ./PEX-labs
}
        
    
