alias g='git'
alias gs='git status'
alias gd='git diff'
alias ga='git add'

alias d=docker

make_completion g git
make_completion ga "git add"
make_completion gd "git diff"
make_completion gs "git status"
make_completion d docker

set PATH ~/opt/brew/bin ~/opt/brew/sbin $PATH ~/code/bin/ ~/code/ghar/bin ~/opt/brew/share/python

set -x MANPATH (cat /etc/manpaths /etc/manpaths.d/**) ~/opt/brew/share/man

set fish_greeting ""

set --export EDITOR "~/code/bin/subl -w"

eval (opam config env)

set -x DOCKER_HOST tcp://192.168.59.103:2375

# TODO : this might be irrelevant for the moment
# include a few additional manpage generated completions
# e.g. eval $__fish_datadir/tools/create_manpage_completions.py ~/opt/brew/share/man/man**/rcup.1
# hmm, why are these not being picked up automatically
for i in ~/.config/fish/generated_completions/*.fish
  . $i
end