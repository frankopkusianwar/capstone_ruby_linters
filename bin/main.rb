#!/usr/bin/env ruby
if ARGV
  path = ARGV[0]
  File.exist?(path) ? 'true' : "Could not find #{path} file"
  file = File.open(path)
  all_lines = file.readlines.map(&:chomp)
  all_lines
#   File.close(path)
  lines = []
  all_lines.each_with_index do |value, index|
    line_no = index + 1
    line_content = value
    file_name = path
    # lines << line
  end

end
puts '#error type in file #filename on line #line number. #error msg'