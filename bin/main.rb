#!/usr/bin/env ruby
require_relative '../lib/modules/controller'

errors = []

if ARGV.length >= 1
  path = ARGV[0]
  valid_path = /^[\W|\w]+.js$/
  if valid_path.match?(path)
    Utilities.start_lint(path,errors)
  else
    puts 'check js files in directory and lint them'
  end
else
  Utilities.check_root_dir(path)
end

if errors.length >= 1
  errors.each do |error|
    puts "#{error.type} in file #{error.line.file_name}:on line #{error.line.line_no}, #{error.msg}"
    puts "#{errors.length} errors found"
  end
else
  puts "Your code is clean, no errors found"
end