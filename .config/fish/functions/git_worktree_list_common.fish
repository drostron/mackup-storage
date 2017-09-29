function git_worktree_list_common
  git -C ~/code/quasar worktree list
  echo
  git -C ~/code/sd-backend worktree list
end
