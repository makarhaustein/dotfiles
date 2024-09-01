export PATH="$PATH:$HOME/bin"

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


 
# --- thefuck --- 
eval $(thefuck --alias)

# ----- fzf -----
eval "$(fzf --zsh)"
# Fd instead of find
export FZF_DEFAULT_COMMAND="fd --type=f --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

fzf_compgen_path() {
  fd --exclude .git --hidden . "$1"
}

fzf_compgen_dir() {
  fd --exclude .git --hidden --type=d . "$1"
}
# Preview files
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

