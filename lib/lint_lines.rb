require_relative './lint_errors'
# rubocop:disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
class Line
  attr_reader :line_no, :content, :file_name
  def initialize(line_no, content, file_name)
    @line_no = line_no
    @content = content
    @file_name = file_name
  end

  def self.check_all_errors(errors, item)
    item.check_missing_semi_colon(errors, item)
    item.check_missing_var(errors, item)
    item.check_using_floats(errors, item)
    item.check_accidental_assignment(errors, item)
    item.check_concat(errors, item)
  end

  def valid_line?(line)
    condition = if line.content.empty?
                  false
                elsif line.content[0].include?('/')
                  false
                else
                  true
                end
    condition
  end

  def check_missing_semi_colon(errors, item)
    if valid_line?(item) == true
      if item.content[content.length - 1].include?(';') == false
        error = LintErrors.new(item)
        errors << error.raise_line_semicolon
      end
    end
    errors
  end

  def check_using_floats(errors, item)
    operations = ['+', '-', '*', '/']
    if valid_line?(item) == true
      operations.each do |x|
        next unless item.content.chars.include?(x)

        if item.content.include?('.')
          error = LintErrors.new(item)
          errors << error.raise_floats
        end
      end
    end
    errors
  end

  def check_missing_var(errors, line)
    if valid_line?(line) && line.content.chars.include?('=')
      characters = line.content.split(' ')
      if characters[0] != 'var'
        error = LintErrors.new(line)
        errors << error.raise_var
      end
    end
    errors
  end

  def check_accidental_assignment(errors, line)
    if valid_line?(line)
      count = 0
      if line.content.include? 'if'
        line.content.chars.each do |item|
          count += 1 if item == '='
        end
        if count < 2
          error = LintErrors.new(line)
          errors << error.raise_invalid_comparison
        end
      end
    end
    errors
  end

  def check_empty_position(line, pos)
    if line.content.chars[pos - 1] != ' ' && line.content.chars[pos + 1] != ' '
      true
    else
      false
    end
  end

  def check_concat(errors, line)
    line.content.chars.each_with_index do |item, index|
      next unless item == '+'

      pos = index
      new_str = line.content.chars[pos - 2] + line.content.chars[pos - 1] +
                line.content.chars[pos] + line.content.chars[pos + 1] + line.content.chars[pos + 2]
      new_str.gsub!(/\s+/, '')
      new_str.chars.each_with_index do |value, indx|
        next unless value == '+'

        new_pos = indx
        if new_str[new_pos - 1].include? '"'
          unless new_str[new_pos + 1].include? '"'
            error = LintErrors.new(line)
            errors << error.raise_no_interger_string
          end
        elsif new_str[new_pos + 1].include? '"'
          unless new_str[new_pos - 1].include? '"'
            error = LintErrors.new(line)
            errors << error.raise_no_interger_string
          end
        end
      end
    end
    errors
  end

  def check_missing_close_parenthesis(errors, line)
    arr = []
    if valid_line?(line) == true
      line.content.chars.each do |x|
        if x == ')' && arr.empty?
          false
        elsif x == '('
          arr << x
        elsif x == ')'
          arr.pop
        end
      end
      if arr.empty?
        false
      else
        error = LintErrors.new(line)
        errors << error.raise_line_parenthesis
      end
    end
    errors
  end
end

# rubocop:enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
