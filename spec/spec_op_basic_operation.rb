require File.expand_path('../../lib/konbu/op/basic_operation', __FILE__)
require File.expand_path('../../lib/konbu/op/add', __FILE__)
require File.expand_path('../../lib/konbu/op/sub', __FILE__)
require File.expand_path('../../lib/konbu/op/mul', __FILE__)
require File.expand_path('../../lib/konbu/op/div', __FILE__)

describe Konbu::BasicOperation do
  describe '#push' do
    let(:bop) { Konbu::BasicOperation.new }
    context 'when object is String class' do
      it 'to (fix|big)num' do
        bop.push('0000')
        expect(bop.stack[-1].class).to eq(Fixnum)
      end

      it 'to float' do
        bop.push('1.1')
        expect(bop.stack[-1].class).to eq(Float)
      end
    end

    context 'when object is Add class' do
      it 'stack[-1] is Konbu::Add class object' do
        add = Konbu::Add.new
        bop.push(add)
        expect(bop.stack[-1].class).to eq(Konbu::Add)
      end
    end

    context 'when object is Sub class' do
      it 'stack[-1] is Konbu::Sub class object' do
        sub = Konbu::Sub.new
        bop.push(sub)
        expect(bop.stack[-1].class).to eq(Konbu::Sub)
      end
    end

    context 'when object is Mul class' do
      it 'stack[-1] is Konbu::Mul class object' do
        mul = Konbu::Mul.new
        bop.push(mul)
        expect(bop.stack[-1].class).to eq(Konbu::Mul)
      end
    end

    context 'when object is Div class' do
      it 'stack[-1] is Konbu::Div class object' do
        div = Konbu::Div.new
        bop.push(div)
        expect(bop.stack[-1].class).to eq(Konbu::Div)
      end
    end
  end
end
