#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -f ~/.Xmodmap ]; then
  xmodmap ~/.Xmodmap
fi
