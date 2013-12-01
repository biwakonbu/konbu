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
      if /[0-9]+\.[0-9]+/ == object
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

class Mul < BasicOperation
  def initialize
    super
  end

  def calc
    result = @stack.shift
    @stack.each do |t|
      case t
      when Fixnum, Bignum, Float
        result *= t
      else
        result *= t.calc
      end
    end

    result
  end
end

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

class Parser
  def initialize(file)
    @file = file
    @operation = OP.new
  end

  def run
    parse
  end

  def parse
    open(@file, 'r') do |f|
      opr = /add|sub|mul|div/
      num = /[0-9]+/
      nest = 0
      pre_token = nil
      f.each do |l|
        token = l.scan(/(?:#{opr}|:|#{num})/)
        token.each do |t|
          case t
          when opr
            @operation.stack_operand(t, nest)
          when num
            @operation.value.nest(@operation.value, t, nest-1)
          when /:/
            if pre_token =~ /add|sub|mul|div/
              nest += 1
            else
              nest -= 1
              if nest == 0
                p @operation.value
                p @operation.value.calc
                @operation = OP.new
              end
            end
          end
          # case end
          pre_token = t
        end
        # token.each end
      end
      # f.each end
    end
    # open end
  end
  # def parse end

  def debug
    p @operation.value.calc
  end
end

parse = Parser.new(ARGV[0])
parse.run

