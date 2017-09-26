# In the spirit of bash's PROMPT_COMMAND
#
# Regarding being located in ~/config/fish/conf.d instead of ~/config/fish/functions,
# see https://github.com/fish-shell/fish-shell/issues/2942#issuecomment-210692914
function prompt_command_approx --on-event fish_prompt
  echo -ne "\033];"(prompt_pwd)"\007"
end
