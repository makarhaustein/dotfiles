export PATH="$PATH:$HOME/bin"

# Source
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/makarh/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Custom aliases
alias sudo='sudo '
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias rmorphans='pacman -Qtdq | sudo pacman -Rns -'
