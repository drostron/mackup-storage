# completion for aliases
# workaround solution from issue comments
# here until issue is resolved https://github.com/fish-shell/fish-shell/issues/393
function make_completion --argument alias command
  complete -c $alias -a "(
    set -l cmdTokens (commandline -op);
    set -l currentCmdToken (commandline -pt);
    set -e cmdTokens[1];
    if test \$cmdTokens[-1] = \$currentCmdToken; set -e cmdTokens[-1]; end;
    complete -C\"$command \$cmdTokens \$currentCmdToken\";
  )"
end
