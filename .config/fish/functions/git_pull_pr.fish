function git_pull_pr
  git pull upstream refs/pull/(git rev-parse --abbrev-ref HEAD | sed s/PR-//)/head
end
