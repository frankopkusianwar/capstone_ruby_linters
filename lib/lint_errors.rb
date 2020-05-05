require 'colorize'

class LintErrors
  attr_reader :line, :type, :msg
  def initialize(line)
    @line = line
  end

  def raise_line_semicolon
    @type = 'Warning'
    @msg = 'End of line missing semi colon'
    color_msg
  end

  def raise_line_parenthesis
    @type = 'Syntax Error'
    @msg = 'missing closing parenthesis'
    color_msg
  end

  def raise_var
    @type = 'Syntax Error'
    @msg = 'missing var keyword for variable declaration'
    color_msg
  end

  def raise_floats
    @type = 'Warning'
    @msg = 'avoid using floats in mathematical operations'
    color_msg
  end

  def raise_invalid_comparison
    @type = 'Syntax Error'
    @msg = 'invalid comparison operator = for if statement'
    color_msg
  end

  def raise_no_interger_string
    @type = 'Warning'
    @msg = 'detected integer and string addition'
    color_msg
  end

  def color_msg
    @type = if @type == 'Syntax Error'
              @type.red
            else
              @type.yellow
            end
    self
  end
end
