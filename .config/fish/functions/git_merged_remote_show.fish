function git_merged_remote_show
  git branch -r --merged $argv[1] | grep "^. $argv[2]" | sed 's/.*\\///' | grep -v "$argv[1]"
end
