function add_to_local_dictionary
  echo $argv[1] >> ~/Library/Spelling/LocalDictionary
  killall AppleSpell
end
