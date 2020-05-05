require_relative '../lib/lint_files'
require_relative '../lib/lint_lines'

describe 'LintFile' do

    let(:file) { LintFile.new('bin/test2.js') }

    describe '#open_file' do
        it 'should open return an open file' do
          expect(file.open_file(file.file_name)).to be(true)
        end
    end
end

