require File.expand_path('../basic_operation', __FILE__)

module Konbu
  class Add < BasicOperation
    def initialize
      super
    end

    def calc
      result = 0
      @stack.each do |t|
        case t
        when Fixnum, Bignum, Float
          result += t
        else
          result += t.calc
        end
      end

      result
    end
  end
end
