function write_chrome_tabs_to_file_and_open
  list_chrome_tabs > $argv[1]
  subl $argv[1]
end