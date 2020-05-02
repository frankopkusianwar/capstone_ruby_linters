class LintFile

    attr_reader : file_path_name
    def initialize(file_path_name)
        @file_name = file_path_name
    end

    def read_lines(@file_name)
        File.read_lines(@file_path_name)
    end

    def close_file(@file_path_name)
        File.close(@file_path_name)
    end
end