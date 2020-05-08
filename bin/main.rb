#!/usr/bin/env ruby
require_relative '../lib/modules/controller'

errors = []

if ARGV.length >= 1
  path = ARGV[0]
  valid_path = /^[\W|\w]+.js$/
  if valid_path.match?(path)
    Controller.start_lint(path, errors)
  else
    Controller.start_lint_dir(path, errors)
  end
else
  files = Controller.find_files(path)
  if files.is_a?(String)
    puts files
  else
    Controller.start_root_lint(files, errors)
  end
end

if errors
  errors.each do |error|
    puts "#{error.type} in file #{error.line.file_name}:on line #{error.line.line_no}, #{error.msg}"
  end
  puts "#{errors.length} offenses detected"
end
