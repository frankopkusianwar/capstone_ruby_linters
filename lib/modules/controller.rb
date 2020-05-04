require_relative '../lint_files'
require_relative '../lint_lines'

module Utilities

    def self.file_exist?(path)
        File.exist?(path) ? true : "Could not find #{path} file, ensure you have entered a valid path"
    end

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

    def self.start_lint(path, errors)
      if file_exist?(path) == true
        file = LintFile.new(path)
        file.lines.each { |item| errors = Line.check_all_errors(errors, item) }
      else
        puts file.file_exist?(file.file_name)
      end
    end
end