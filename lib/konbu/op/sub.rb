require File.expand_path('../basic_operation', __FILE__)

module Konbu
  class Sub < BasicOperation
    def initialize
      super
    end

    def calc
      if @stack.size == 1
        result = -@stack.shift
      else
        result = @stack.shift
      end
      @stack.each do |t|
        case t
        when Fixnum, Bignum, Float
          result -= t
        else
          rsult -= t.calc
        end
      end

      result
    end
  end
end
