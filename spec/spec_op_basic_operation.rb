require File.expand_path('../../lib/konbu/op/basic_operation', __FILE__)

describe Konbu::BasicOperation do
  describe '#push' do
    context 'when object is String' do
      let(:bop) { Konbu::BasicOperation.new }
      it 'to (fix|big)num' do
        bop.push('0000')
        expect(bop.stack[0].class).to eq(Fixnum)
      end

      it 'to float' do
        bop.push('1.1')
        expect(bop.stack[0].class).to eq(Float)
      end
    end
  end
end
