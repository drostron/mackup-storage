function git_list_assume_unchanged
  git ls-files -v | grep '^[[:lower:]]'
end
