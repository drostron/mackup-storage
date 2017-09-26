function git_worktree_list_common
  git -C ~/code/quasar worktree list
  echo
  git -C ~/code/slamdata-backend worktree list
end
