export PATH="$PATH:$HOME/bin"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# Fixes vim like motion not deleting non-inserted chars
bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/makarh/.zshrc'

autoload -Uz compinit
compinit

# End of lines added by compinstall
# --- autocompl ---
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# --- Neovim
export EDITOR=nvim

# Custom aliases
alias sudo='sudo '
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias rmorphans='pacman -Qtdq | sudo pacman -Rns -'

# ---- thefuck ---- 
eval $(thefuck --alias)

# ------ eza ------
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"

# ------ fzf ------
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
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}
# fzf git script
source "$HOME/.zsh/scripts/fzf-git/fzf-git.sh"

# ---- zoxide -----
eval "$(zoxide init zsh)"
alias cd="z"

# - powerlevel10k -
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# -- rofi theme ---
export PATH=$HOME/.config/rofi/scripts:$PATH

# firefox 
MOZ_ENABLE_WAYLAND=1
