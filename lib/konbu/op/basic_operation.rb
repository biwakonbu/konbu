module Konbu
  class BasicOperation
    attr_accessor :stack

    def initialize
      @val = 0
      @stack = []
    end

    def val; end

    def push(object)
      case object
      when String
        if /[0-9]+\.[0-9]+/ =~ object
          @stack << object.to_f
        else
          @stack << object.to_i
        end
      else
        @stack << object
      end
    end

    def nest(pre_op, object, nest)
      if nest > 0
        nest(pre_op.stack[-1], object, nest-1)
      elsif nest <= 0
        pre_op.push(object)
      end
    end
  end
end
