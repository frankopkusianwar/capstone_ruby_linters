class  Line
    attr_reader : line_no, content
    def initialize(line_no, content)
        @line_no = line_no
        @content = content
    end
end