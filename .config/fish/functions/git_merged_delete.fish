function git_merged_delete
  git_merged_show $argv[1] | xargs -n 1 git branch -d
end
