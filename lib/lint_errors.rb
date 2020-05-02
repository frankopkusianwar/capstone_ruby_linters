class Lint_errors
    attr_reader : type, msg
    def initialize(type, msg)
        @type = type
        @msg = msg
    end
end