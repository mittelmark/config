#!/bin/bash
alias mfontsel="xfontsel -pattern '*-m-*' -scale"
export PATH=~/.local/bin:$PATH
function backup-cpp {
    cd ~
    zip -yr .config/jasspa .local/bin .local/share/jasspa \
        .local/share/fonts ./PEX-labs
}
        
    
