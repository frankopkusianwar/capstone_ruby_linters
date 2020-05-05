require_relative '../lib/modules/controller'

describe 'Controller'do

let(:errors) { [] }
let(:dir) { './bin' }
let(:file) { './bin/test.js' }
let(:error_file) { './bin/test_err.js' }
let(:no_file) { './bin/test_no.js' }
let(:no_dir) { 'no_dir' }
let(:dir_no_files) { '/lib' }
let(:root_dir) { ['./bin/test_err.js'] }

    describe '#file_exist' do
        it "should return true when a file exists" do
            expect(Controller.file_exist?(file)).to eql(true)
        end

        it "should return a string when no file is found " do
            expect(Controller.file_exist?(no_file)).to be_a(String)
        end
    end

    describe '#dir_exist' do
        it "should return true when a directory exists" do
            expect(Controller.dir_exist?(dir)).to eql(true)
        end

        it "should return a string when no directory is found " do
            expect(Controller.dir_exist?(no_dir)).to be_a(String)
        end
    end

    describe '#find_files' do
        it 'should return a files array when files found' do
            expect(Controller.find_files(dir)).to be_an(Array)
        end

        it 'should return a string no files found' do
            expect(Controller.find_files(dir_no_files)).to be_a(String)
        end
    end

    describe '#start_lint' do
        it 'returns array of errors when errors found in file' do
            Controller.start_lint(error_file, errors)
            expect(errors.empty?).not_to eql(true)
        end

        it 'returns empty array when no errors found' do
            Controller.start_lint(file, errors)
            expect(errors.empty?).to eql(true)
        end
    end

    describe '#start_lint_dir' do
        it 'should return an array of errors if errors found in directory' do
          expect(Controller.start_lint_dir(dir, errors)).to be_an(Array)
        end
    end

    describe '#start_lint_root' do
        it 'should return an array of errors if errors found in root directory' do
            expect(Controller.start_root_lint(root_dir, errors)).to be_an(Array)
        end
    end
end