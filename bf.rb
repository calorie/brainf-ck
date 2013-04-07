# coding: utf-8
class Brainfuck

  def initialize
    @p = []
    @pc = 0
    @pc_stack = []
    @fp_stack = []
  end

  def bf
    File.open(ARGF.filename) do |f|
      f.each_char do |c|
        @p[@pc] ||= 0
        case c
        when '+'
          @p[@pc] += 1
        when '-'
          @p[@pc] -= 1
        when '>'
          @pc += 1
        when '<'
          @pc -= 1
        when '['
          @pc_stack.push(@pc)
          @fp_stack.push(f.pos)
        when ']'
          unless @p[@pc] == 0
            @pc = @pc_stack.pop
            f.seek(@fp_stack.pop - 1,IO::SEEK_SET)
          end
        when '.'
          print @p[@pc].chr
        end
      end
    end
  end
end

b = Brainfuck::new
b.bf
