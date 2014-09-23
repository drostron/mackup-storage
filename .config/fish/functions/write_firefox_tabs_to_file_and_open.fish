function write_firefox_tabs_to_file_and_open
  list_firefox_tabs > $argv[1]
  subl $argv[1]
end