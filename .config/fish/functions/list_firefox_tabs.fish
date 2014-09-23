function list_firefox_tabs
  cat ~/Library/Application\ Support/Firefox/Profiles/*.default/sessionstore.js \
    | jq -r '.windows[].tabs[] | .entries[.index-1] | .title + "\n" + .url + "\n"'
end
