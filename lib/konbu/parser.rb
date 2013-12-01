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
