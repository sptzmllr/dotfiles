autoload -U colors && colors

# Pure promt
fpath+=$HOME/code/pure
autoload -U promptinit; promptinit
prompt pure

EDITOR=nvim

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history #Historyfile in ~/.cache

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)               # Include hidden files.


# Aliases 
[ -f "$HOME/.config/zsh/aliasrc" ] && source "$HOME/.config/zsh/aliasrc"

# Source plugins autosuggestions, syntax highlighting, autojump
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/autojump/autojump.zsh 2>/dev/null
