# oh my zsh
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git z fnm node npm brew fd fzf zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# aliases
alias dotnetx64="/usr/local/share/dotnet/x64/dotnet"
alias c="clear"
alias omzr="omz reload"
alias lg="lazygit"
alias hh="h $HOME"
alias hhc="h $HOME/.config"
# grb -> git checkout recent branch
alias grb='git branch --sort=-committerdate | grep -v "$(git branch --show-current)" | fzf --header "Checkout Recent Branch ( $(git branch --show-current))" --preview "git diff {1} --color=always" --pointer="" | xargs git checkout'
alias gs='git status'

# functions
# vim -> open vim in the current directory or open the target file
function vim() {
    if [[ $# -eq 0 ]]; then
        nvim .
    else
        nvim "$@"
    fi
}

# hx-> open helix in the current directory or open the target file
function h() {
    if [[ $# -eq 0 ]]; then
        hx .
    else
        hx "$@"
    fi
}

# fvim -> find and open a file in vim
function fhx() {
    if [[ $# -eq 0 ]]; then
        fd -t f | fzf --header "Open File in Helix" --preview "bat --color=always {}" | xargs hx
    else
        fd -t f | fzf --header "Open File in Helix" --preview "bat --color=always {}" -q "$@" | xargs hx
    fi
}

# fzf
export FZF_DEFAULT_OPTS="--bind ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down --preview 'bat --color=always{}'"
export FZF_DEFAULT_OPTS=" \
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

# nvm
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# Something I found to automatically run nvm use in the current dir when using node
# https://stackoverflow.com/questions/57110542/how-to-write-a-nvmrc-file-which-automatically-change-node-version
# # place this after nvm initialization!
# # autoload -U add-zsh-hook
# # load-nvmrc() {
# #   local node_version="$(nvm version)"
# #   local nvmrc_path="$(nvm_find_nvmrc)"

# #   if [ -n "$nvmrc_path" ]; then
# #     local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

# #     if [ "$nvmrc_node_version" = "N/A" ]; then
# #       nvm install
# #     elif [ "$nvmrc_node_version" != "$node_version" ]; then
# #       nvm use
# #     fi
# #   elif [ "$node_version" != "$(nvm version default)" ]; then
# #     echo "Reverting to nvm default version"
# #     nvm use default
# #   fi
# # }
# # add-zsh-hook chpwd load-nvmrc
# # load-nvm

# docker desktop
source /Users/cshort/.docker/init-zsh.sh || true

# pnpm
export PNPM_HOME="/Users/cshort/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# git
export GIT_EDITOR=hx

# lazygit
export XDG_CONFIG_HOME="$HOME/.config"
export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml,$HOME/.config/lazygit/themes/catppuccin-macchiato/red.yml"

# starship.rs
eval "$(starship init zsh)"

# libpq
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

export PATH="/Users/cshort/Code/bin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.

# For ruby packages like Solargraph
export PATH="$HOME/.gem/ruby/3.0.0/bin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
