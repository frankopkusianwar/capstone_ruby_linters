require_relative '../lint_files'

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
        file = LintFile.new(path)
        if file.file_exist?(file.file_name)
          open_file = file.open_file(file.file_name)
          file.read_lines(open_file)
        else
          puts file.file_exist(path)
        end
    end
end