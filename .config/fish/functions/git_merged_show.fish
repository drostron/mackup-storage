function git_merged_show
  git branch --merged $argv[1] | grep -v ". $argv[1]\$"
end
