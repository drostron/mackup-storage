function git_checkout_pr
  set pr_number $argv[1]
  git fetch upstream pull/$pr_number/head:PR-$pr_number
  git checkout PR-$pr_number
end
