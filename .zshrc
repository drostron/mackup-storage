# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gnzh"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

alias ls='ls -GF'
alias l='ls -l'
alias la='l -a'
alias lh='ll -h'
alias lah='lh -a'
unalias history

HISTSIZE=500000
SAVEHIST=$HISTSIZE

# search for a line which has the entire starting point up to the cursor position
# <option>+<up-arrow>   '^[^[[A'
# <option>+<down-arrow> '^[^[[B'
# <up-arrow> '^[[A'
# <down-arrow> '^[[B'
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

# scala
path+=~/opt/scala/bin
manpath+=~/opt/scala/man
alias scala-2.10=~/opt/scala-2.10.2/bin/scala
alias scala-2.10-open-docs='open ~/opt/scala-docs-2.10.2/index.html'
function scala-sbt-console {
  pushd ~/Dropbox/code/scala-sbt-console/; sbt "$@"; popd
}
alias ssc=scala-sbt-console

# diffmerge
path+=/Applications/DiffMerge/CommandLine
manpath+=/Applications/DiffMerge/CommandLine

# ant
ANT_OPTS="-XX:MaxPermSize=256m -Xmx512m"

# maven
alias mvn2=~/opt/apache-maven-2.2.1/bin/mvn
export MAVEN_OPTS="-XX:MaxPermSize=256m -Xmx512m"

# log4tailer
alias log4tailer='~/opt/log4tailer/log4tail -c ~/.log4tailerConf'

# shell conveniences
path+=~/code/bin

# personal ruby gems
path+=~/.gem/ruby/1.8/bin

# octave
alias octave='rlwrap /Applications/Octave.app/Contents/Resources/bin/octave'

# mcat
path+=~/opt/mcat

# brew
path[1,0]=(~/opt/brew/bin ~/opt/brew/sbin ~/opt/brew/share/npm/bin)

# additional zsh-completions via brew : https://github.com/zsh-users/zsh-completions
fpath=(~/opt/brew/share/zsh-completions $fpath)
compinit

# ws-curl
export ACS_USER='d'
export ACS_PASSWORD='d'
path+=~/code/ws-curl

# editor (used by cvc)
export EDITOR=~/code/bin/subl" -w"

# expose brew's python share
path+=~/opt/brew/share/python

# smlnj
path+=~/opt/brew/Cellar/smlnj/110.75/libexec/bin

path+=~/bin

# zsh auto-correct mods
# unsetopt correct_all   ## turn off completely if necessary
alias git='nocorrect git'
alias grep='nocorrect grep'
alias ssh='nocorrect ssh'
alias javac='nocorrect javac'
alias java='nocorrect java'

# a few git aliases
alias gs='git status'
alias gd='git diff'

# jvm
export JAVA_OPTS='-Dfile.encoding=UTF-8'

# play
path+=~/opt/play-2.1.1

# sbt-revolver, jrebel
#export JREBEL_PATH=/Users/dave/opt/jrebel/jrebel.jar

# OPAM configuration
#eval `opam config env`
#. /Users/dave/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# json formatting
alias jsonf='python -m json.tool'

# simple web server
alias simple-web-server='python -m SimpleHTTPServer'

# vagrant
alias v=vagrant

# julia
#alias julia=/Applications/Julia-0.2.0.app/Contents/Resources/julia/bin/julia
alias julia=/Applications/Julia-0.3.0-prerelease-a673e4c4de.app/Contents/Resources/julia/bin/julia
#alias julia=/Applications/Julia-0.3.0-prerelease-d19560d5b2.app/Contents/Resources/julia/bin/julia

# docker, boot2docker
export DOCKER_HOST=tcp://127.0.0.1:4243

# libzmq, required by gozmq, required by igo
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/Users/dave/opt/zeromq-3.2.4/src

# go
export GOPATH=~/code/gocode
path+=~/opt/homebrew/Cellar/go/1.2/libexec/bin

# shen
alias shen=~/opt/Shen_31_SBCL_x86_64_OS_X

# haskell
path[1,0]=~/Library/Haskell/bin
# added by travis gem
[ -f /Users/dave/.travis/travis.sh ] && source /Users/dave/.travis/travis.sh

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
