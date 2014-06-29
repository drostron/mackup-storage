function git_prompt_status_legend
  echo branch status
  set_color $fish_color_git_clean
  echo ✓ clean
  set_color $fish_color_git_staged
  echo ⚡ staged
  set_color $fish_color_git_dirty
  echo ⚡ dirty
  set_color normal
  echo
  echo file statuses
  for i in $fish_prompt_git_status_order
    set -l color_name fish_color_git_$i
    set -l status_name fish_prompt_git_status_$i
    set_color $$color_name
    echo -n $$status_name
    echo " $i"
    set_color normal
  end
end