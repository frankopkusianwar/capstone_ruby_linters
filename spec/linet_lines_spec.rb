require_relative '../lib/lint_lines'

describe 'Line' do
  let(:line_obj_err) { Line.new('2', 'line message', 'bin/test2.js') }
  let(:line_obj_flts) { Line.new('2', 'var x = 2.0 + 1;', 'bin/test2.js') }
  let(:line_obj_par) { Line.new('2', 'if(;', 'bin/test2.js') }
  let(:line_obj_var) { Line.new('2', 'x = 2.0 + 1;', 'bin/test2.js') }
  let(:line_obj) { Line.new('2', '//line message', 'bin/test2.js') }
  let(:line_obj_cnct) { Line.new('2', 'var x = 2 + "3";', 'bin/test2.js') }
  let(:line_obj_acc) { Line.new('2', 'if(x=y);', 'bin/test2.js') }
  let(:errors) { [] }

  describe '#self.check_all_errors' do
    it 'should return an array of errors if errors found' do
      expect(Line.check_all_errors(errors, line_obj_err)).to be_an(Array)
    end

    it 'should return an empty array of errors if errors not found' do
      arr = Line.check_all_errors(errors, line_obj)
      expect(arr.length).to eql(0)
    end
  end

  describe '#valid_line' do
    it 'returns true for valid line' do
      expect(line_obj_err.valid_line?(line_obj_err)).to be(true)
    end

    it 'should return false for an invalid line' do
      expect(line_obj.valid_line?(line_obj)).to be(false)
    end
  end

  describe '#check_using_floats' do
    it 'returns an array containing errors if erros found' do
      arr = line_obj_flts.check_using_floats(errors, line_obj_flts)
      expect(arr.length).to eql(1)
    end

    it 'an empty array if no float errors found' do
      arr = line_obj.check_using_floats(errors, line_obj)
      expect(arr.length).to eql(0)
    end
  end

  describe '#check_missing_var' do
    it 'returns an array containing errors if errors found' do
      arr = line_obj_var.check_missing_var(errors, line_obj_var)
      expect(arr.length).to eql(1)
    end

    it 'an empty array if var is found in var declaration found' do
      arr = line_obj_flts.check_missing_var(errors, line_obj_flts)
      expect(arr.length).to eql(0)
    end
  end

  describe '#check_accidental_assignment' do
    it 'returns an array containing errors if errors found' do
      arr = line_obj_acc.check_accidental_assignment(errors, line_obj_acc)
      expect(arr.length).to eql(1)
    end

    it 'returns an empty array if errors not found' do
      arr = line_obj_flts.check_accidental_assignment(errors, line_obj_flts)
      expect(arr.length).to eql(0)
    end
  end

  describe '#check_concat' do
    it 'returns an array containing errors if errors found' do
      arr = line_obj_cnct.check_concat(errors, line_obj_cnct)
      expect(arr.length).to eql(1)
    end

    it 'returns an empty array if errors not found' do
      arr = line_obj_flts.check_concat(errors, line_obj_flts)
      expect(arr.length).to eql(0)
    end
  end

  describe '#check_missing_close_parenthesis' do
    it 'returns an array containing errors if errors found' do
      arr = line_obj_par.check_missing_close_parenthesis(errors, line_obj_par)
      expect(arr.length).to eql(1)
    end

    it 'returns an empty array if errors not found' do
      arr = line_obj_flts.check_missing_close_parenthesis(errors, line_obj_flts)
      expect(arr.length).to eql(0)
    end
  end
end
