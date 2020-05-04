require_relative './lint_errors'
class  Line
    attr_reader :line_no, :content, :file_name
    def initialize(line_no, content, file_name)
        @line_no = line_no
        @content = content
        @file_name = file_name
    end

    def self.check_all_errors(errors, item)
        item.check_missing_semi_colon(errors, item)
        item.check_missing_var(errors, item)
        item.check_using_floats(errors,item)
    end

    def valid_line?(line)
        condition = true
        if line.content.empty? 
            condition = false
        elsif line.content[0].include?('/')
            condition = false
        else
            condition = true
        end
        condition
    end

    def check_block?(line)
        block = ['if', 'else', 'for', 'while']
        condition = false
        block.each do |item|
            if line.content.include?(item)
                condition = false
            else
                condition = true
            end
        end
        condition
    end

    def check_missing_semi_colon(errors, item)
        if valid_line?(item) == true 
          if item.content[content.length-1].include?(';') == false
            error = Lint_errors.new(item)  
            errors << error.raise_line_semicolon
          end
        end
        errors
    end

    def check_using_floats(errors, item)
      operations = ["+", "-", "*", "/"]
      if valid_line?(item) == true
        operations.each do |x|
          if item.content.chars.include?(x)
            if item.content.include?(".")
                error = Lint_errors.new(item)  
                errors << error.raise_floats
            end 
          end
        end
      end
      errors
    end

    def check_missing_var(errors, line)
        if valid_line?(line) && line.content.chars.include?('=')
            characters = line.content.split(" ")
            if characters[0] != 'var'
                error = Lint_errors.new(line)  
                errors << error.raise_var
            end
        end
        errors
    end

    def check_missing_close_parenthesis(errors, line)
        arr = []
        if valid_line?(line) == true
            line.content.chars.each do |x|
                if x == ')' && arr.size == 0
                    false
                elsif x == '('
                    arr << x
                elsif x == ")"
                    arr.pop
                end
            end
            if arr.size == 0
                false
            else
                error = Lint_errors.new(line)  
                errors << error.raise_line_parenthesis
            end
        end
        errors
    end
end