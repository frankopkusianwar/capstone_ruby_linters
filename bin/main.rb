#!/usr/bin/env ruby
require_relative '../lib/modules/utilities'

if ARGV.length >= 1
  path = ARGV[0]
  valid_path = /^[\W|\w]+.js$/
  if valid_path.match?(path)
    Utilities.start_lint(path)
  else
    puts 'check js files in directory and lint them'
  end
else
  Utilities.check_root_dir(path)
end
puts '#error type in file #filename on line #line number. #error msg'