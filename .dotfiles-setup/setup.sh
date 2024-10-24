#!/usr/bin/env bash

####################################################################################
#### Setting the whole thing up, user always chooses before installing anything ####
####################################################################################

# Possibly not complete and outdated

######### Packages used in dotfiles
packages=(
    "git"
    "neovim" # editor
    # Zsh config and nice to have cli extensions
    "zsh" # shell
    "zsh-theme-powerlevel10k-git" # prompt 
    "bat" # better cat
    "bat-extras" # configs stuff like man colors (via bat)
    "zoxide" # better cd
    "eza" # better ls
    "delta"
    # Terminal
    "kitty"
    # Hyprland
    "hyprland"
    "waybar" # topbar
    "hyprpaper" # wallpaper
    "cliphist"
    "mpd"
    "rofi"
    "thefuck"
    "fzf"
)

######### Pacman package installation
# Detect the package manager
if [ ! -f /etc/arch-release ]; then
    echo "Only Arch is supported!"
    exit 1
fi

# Print all packages
echo "=== Packages to be installed via pacman ==="
echo "${packages[@]}"
echo ""

# User always chooses if he wants to install a package
skip_section=false
install_all=false

query_wants_package() {    
    local package="$1"
    local response

    while true; do
	if $skip_section; then
	    return 1;
	fi
	if $install_all; then
	    return 0;
	fi
	echo "Install $package and its dependencies?"
	read -r -p "::[y(es), n(o), a(ll), s(kip section no to all)]: " response
	case "$response" in
	    [Yy]* ) 
		return 0;;
	    [Aa]* )
		install_all=true; 
		echo -e "Installing all packages...\n";
		return 0;; 
	    [Nn]* ) 
		return 1;; 
	    [Ss]* ) 
		skip_section=true;
		echo -e "Not installing any packages in this section...\n";
		return 1;; 
	    * ) 
		echo "Invalid response.";;
	esac
    done 
}

# Install packages
for package in "${packages[@]}"; do
    if pacman -Qi "$package" &> /dev/null; then
        echo "$package is already installed."
    else 
	if query_wants_package "$package"; then
	    if sudo pacman -S --noconfirm "$package"; then
	        echo "$package installed successfully."
            else
                echo "Failed to install $package."
	    fi
   	fi
    fi
done

echo -e "Done.\n"

######### Pacman package installation
echo "=== Packages to be installed from other sources ==="

# Reset option
skip_section=false
install_all=false

if [ ! -d "$HOME/.zsh/scripts/fzf-git/" ] && query_wants_package "fzf-git extension (https://github.com/junegunn/fzf-git.sh.git)"; then 
    git clone "https://github.com/junegunn/fzf-git.sh.git" "$HOME/.zsh/scripts/fzf-git/"
else
    echo "fzf-git extension (https://github.com/junegunn/fzf-git.sh.git) package is already installed."
fi

if [ ! -d "$HOME/.zsh/zsh-autosuggestions/" ] && query_wants_package "zsh autosuggestions (https://github.com/zsh-users/zsh-autosuggestions)"; then 
    git clone "https://github.com/zsh-users/zsh-autosuggestions" "$HOME/.zsh/zsh-autosuggestions"
else
    echo "fzf-git extension (https://github.com/junegunn/fzf-git.sh.git) package is already installed."
fi


echo -e "Done.\n"

######## After (could be automated)
echo "=== Manual Steps (too lazy to automate everything) ==="
if pacman -Qi hyprland &> /dev/null; then
    echo "Setting up hyprland correctly"
    echo "- 1. change monitor config in ~/.config/hypr/hyprpaper.conf" 
    echo "- 2.1 if not using NVIDIA gpu remove commands under corr. section in hyprpaper.conf."
    echo "- 2.2 if using NVidia gpu look up hyprland wiki NVidia guide, there are some kernel params that have to be added."
    echo "- 3. change hyprpaper config in ~/.config/hypr/hyprpaper.conf/ and add wallpapers."
    echo -e "- 4. Potentially setup login manager greetd.\n"
fi

