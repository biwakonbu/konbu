require File.expand_path('../basic_operation', __FILE__)

module Konbu
  class Div < BasicOperation
    def initialize
      super
    end

    def calc
      result = @stack.shift
      @stack.each do |t|
        case t
        when Fixnum, Bignum, Float
          result /= t
        else
          result /= t.calc
        end
      end

      result
    end
  end
end
