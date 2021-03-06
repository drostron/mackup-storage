alias g='git'
alias gs='git status'
alias gd='git diff'
alias ga='git add'

alias d=docker

alias qsbt=~/code/quasar/sbt

make_completion g git
make_completion ga "git add"
make_completion gd "git diff"
make_completion gs "git status"
make_completion d docker

set PATH \
  $PATH

set -x MANPATH            \
  (cat /etc/manpaths)     \
  /usr/share/man          \
  /usr/local/share/man

set fish_greeting ""

# set --export EDITOR "~/code/bin/subl -w"
# set --export EDITOR nvim
set --export EDITOR emacsclient

set -x DOCKER_HOST tcp://192.168.59.103:2376
set -x DOCKER_CERT_PATH /Users/dave/.boot2docker/certs/boot2docker-vm
set -x DOCKER_TLS_VERIFY 1

set -x GOPATH ~/code/gocode/

# status --is-interactive; and . (pyenv init -|psub)
# status --is-interactive; and . (pyenv virtualenv-init -|psub)

# TODO : this might be irrelevant for the moment
# include a few additional manpage generated completions
# e.g. eval $__fish_datadir/tools/create_manpage_completions.py ~/opt/brew/share/man/man**/rcup.1
# hmm, why are these not being picked up automatically
for i in ~/.config/fish/generated_completions/*.fish
  . $i
end

# ↓ Appears to no longer be necessary?
# Per https://github.com/syl20bnr/spacemacs/tree/master/layers/%2Btools/shell#fish-shell-and-ansi-term
# emacs ansi-term support
# if test -n "$EMACS"
#   set -x TERM eterm-color
# end
# this function may be required
# function fish_title
#   true
# end
