function git_worktree_list_common
  git -C ~/code/quasar worktree list
  echo
  git -C ~/code/sb worktree list
end
