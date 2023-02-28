DOTFILES="$HOME/.dotfiles"
source "$DOTFILES/set_shell_prompt.sh"

eval "$(/opt/homebrew/bin/brew shellenv)"

alias vi="nvim"
alias v="nvim"
# alias l="exa -1"
# alias ll="exa -la --header --git"
alias cat="bat --paging=never"
alias cd="z"

# If `tmux` isn't already running, start it.
# if [ "$TMUX" = "" ]; then tmux; fi

# Prevent `.lesshst` file from appearing in $HOME
export LESSHISTFILE="$XDG_STATE_HOME/less/history"

# Paths to projects on Lichtenberg2 cluster.
# Lichtenber2 base directory
LBBASEDIR="lb:/work/groups/da_thchem/members/frederikscherz"
# Rhenium-Fc-Diade
RFD="$LBBASEDIR/rhenium-fc-diade"
# Ferrocene Diazide
FDA="$LBBASEDIR/fc-azides/diazide"


