function git_merged_remote_delete
  git_merged_remote_show $argv[1] $argv[2] | xargs -n 1 git push --delete $argv[2]
end
