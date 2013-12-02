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

    for klass in [Konbu::Add, Konbu::Sub, Konbu::Mul, Konbu::Div]
      context "when object is #{klass} class" do
        it "stack[-1] is #{klass} class object" do
          object = klass.new
          bop.push(object)
          expect(bop.stack[-1].class).to eq(klass)
        end
      end
    end
  end
end
