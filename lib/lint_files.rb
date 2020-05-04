class LintFile

    attr_reader :file_name

    def initialize(file_name)
        @file_name = file_name
    end

    def file_exist?(file_name)
        File.exist?(file_name) ? true : "Could not find #{file_name} file, ensure you have entered a valid path"
    end

    def open_file(file_name)
        File.open(file_name)
    end

    def read_lines(open_file)
        open_file.readlines.map(&:chomp)
    end

    def close_file(file_name)
        File.close(file_name)
    end
end