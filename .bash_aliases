#shopt -s expand_aliases

alias ls="lsd"
alias space="command time -f %Mkb"
alias c1="time g++ -O2 -std=c++17 -Wall -Wextra -Wshadow -Wno-unused-result"
alias c2="time g++ -O2 -std=c++17 -Wall -Wextra -Wshadow -Wno-unused-result -DLOCAL"
alias c3="time g++ -O2 -std=c++17 -Wall -Wextra -Wshadow -Wno-unused-result -pedantic -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC -DLOCAL "
alias c4="time g++ -O2 -std=c++17 -Wall -Wextra -Wshadow -Wno-unused-result -pedantic -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC -fsanitize=address -fsanitize=undefined -DLOCAL" 
alias vifm="bash /home/ishank/.config/vifm/scripts/vifmrun"
alias config='/usr/bin/git --git-dir=/home/ishank/dotfiles/ --work-tree=/home/ishank'
# alias dmenu_run="dmenu_run -h 30 -fn 'Hack:bold:pixelsize=13' -p 'prompt' -nf '#bbc5ff' -nb '#282a36' -sb '#82aaff' -sf '#282a36'"

# debian:- /usr/include/x86_64-linux-gnu/c++/9/bits
# arch:- /usr/include/c++/10.2.0/x86_64-pc-linux-gnu/bits/stdc++.h
