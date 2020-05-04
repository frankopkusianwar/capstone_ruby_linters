class  Line
    attr_reader :line_no, :content
    lines = []
    def initialize(line_no, content)
        @line_no = line_no
        @content = content
    end

    def check_all_errors(item)
        # puts 'check method goes here'
        check_test(item)
        check_test2(item)
    end

    def check_test(line)
        if line.content == "// again"
          puts 'error msg'
        end
    end

    def check_test2(line)
        if line.content == "// yees"
          puts 'error msg2'
        end
    end
end