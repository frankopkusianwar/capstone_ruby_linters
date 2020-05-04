require_relative '../lint_files'
require_relative '../lint_lines'

module Utilities

    def self.dir_exist(path)
        Dir.exist?(path) ? true : "Could not find #{path} directory"
    end

    def self.check_root_dir(path = nil)
        if path
            files = Dir["#{path}/**/*.js"]
            !files.empty? ? files : "No javaScript files found in #{path} directory"
          else
            files = Dir['./**/*.js']
            !files.empty? ? files : 'No javaScript files found in this directory'
        end
    end

    def self.start_lint(path)
      errors = []
      file = LintFile.new(path)
      if file.file_exist?(file.file_name) == true
        opened_file = file.open_file(file.file_name)
        read_lines = file.read_lines(opened_file)
        all_lines = create_lines(read_lines)
        all_lines.each { |item| item.check_all_errors(item) }
      else
        puts file.file_exist?(file.file_name)
      end
    end

    def self.create_lines(read_lines)
      lines = []
      read_lines.each_with_index do |item, index|
        new_line = Line.new(index + 1, item)
        lines << new_line
      end
      lines
    end
end