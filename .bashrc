# A few shell aliases
alias g="git";
alias gs="git status";
alias gd="git diff";
alias ll="ls -lh";
alias la="ls -lah";

# A few script conveniences
export PATH=$PATH:~/Dropbox/scripts/

# A slash (/) aware delete word (ctrl-w)
# From https://unix.stackexchange.com/questions/27927/is-it-possible-to-configure-ctrl-w-delete-word/58491#58491
stty werase undef
bind '\C-w:unix-filename-rubout'
