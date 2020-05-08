class LintFile
  attr_reader :file_name, :lines

  def initialize(file_name)
    @file_name = file_name
    @lines = []
    create_lines
  end

  def open_file
    File.open(file_name)
  end

  def close_file
    File.close(file_name)
  end

  def create_lines
    file = open_file
    file_lines = file.readlines.map(&:chomp)
    file_lines.each_with_index do |value, index|
      line = Line.new(index + 1, value, @file_name)
      @lines << line
    end
  end
end
