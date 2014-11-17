function write_browser_tabs_to_file_and_open
  list_chrome_tabs > $argv[1]
  echo -e "=-=-=-=\n" >> $argv[1]
  list_firefox_tabs >> $argv[1]
  subl $argv[1]
end