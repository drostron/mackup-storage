function git_fetch_checkout_remote_branch
  set repo $argv[1]
  set branch $argv[2]
  git fetch $repo $branch:$branch
  git checkout $branch
end
