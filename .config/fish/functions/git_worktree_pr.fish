function git_worktree_pr
  set pr_number $argv[1]
  set worktree_path ../(basename (pwd))-worktree/PR-$pr_number
  git fetch upstream pull/$pr_number/head:PR-$pr_number
  git worktree add $worktree_path PR-$pr_number
  cd $worktree_path
end
