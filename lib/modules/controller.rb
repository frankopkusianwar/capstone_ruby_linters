require_relative '../lint_files'
require_relative '../lint_lines'

module Controller
  def self.file_exist?(path)
    File.exist?(path) ? true : "Could not find #{path} file, ensure you have entered a valid path"
  end

  def self.dir_exist?(path)
    Dir.exist?(path) ? true : "Could not find #{path} directory, please enter valid directory name"
  end

  def self.find_files(path = nil)
    if path
      files = Dir["#{path}/**/*.js"]
      !files.empty? ? files : "No javascript files found in #{path} directory"
    else
      files = Dir['./**/*.js']
      !files.empty? ? files : 'No javascript files found in this directory'
    end
  end

  def self.check_file_blocks(errors, files)
    files.lines.each do |item|
      item.check_missing_close_parenthesis(errors, item)
    end
    errors
  end

  def self.start_lint(path, errors)
    if file_exist?(path) == true
      file = LintFile.new(path)
      check_file_blocks(errors, file)
      file.lines.each { |item| errors = Line.check_all_errors(errors, item) }
    else
      puts file_exist?(path)
    end
  end

  def self.start_lint_dir(path, errors)
    if dir_exist?(path) == true
      files = find_files(path)
      if files.is_a?(String)
        puts files
      else
        files.each { |item| start_lint(item, errors) }
      end
    else
      puts dir_exist?(path)
    end
  end

  def self.start_root_lint(files, errors)
    files.each { |item| start_lint(item, errors) }
  end
end
