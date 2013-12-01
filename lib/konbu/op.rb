$LOAD_PATH << File.expand_path('../', __FILE__)

require 'op/basic_operation'
require 'op/add'
require 'op/sub'
require 'op/mul'
require 'op/div'

module Konbu
  class OP
    attr_accessor :value

    def initialize
      @value = nil
    end

    def stack_operand(opr, nest)
      case opr
      when /add/
        if nest == 0
          @value = Add.new
        else
          @value.nest(@value, Add.new, nest-1)
        end
      when /sub/
        if nest == 0
          @value = Sub.new
        else
          @value.nest(@value, Sub.new, nest-1)
        end
      when /mul/
        if nest == 0
          @value = Mul.new
        else
          @value.nest(@value, Mul.new, nest-1)
        end
      when /div/
        if nest == 0
          @value = Div.new
        else
          @value.nest(@value, Div.new, nest-1)
        end
      end
    end
  end
end
