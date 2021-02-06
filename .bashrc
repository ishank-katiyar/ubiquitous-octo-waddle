#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash


if [ -f ~/.Xmodmap ]; then
  xmodmap ~/.Xmodmap
fi

if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi