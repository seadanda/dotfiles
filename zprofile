#
# ~/.zprofile
#

[ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] || [ -n "$TMUX" ] || startx
