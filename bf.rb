# coding: utf-8
class Brainfuck

  def initialize
    @p = []
    @pc = 0
    @fp_stack = []
  end

  def bf
    File.open ARGF.path do |f|
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
          @fp_stack.push f.pos
        when ']'
          fp = @fp_stack.pop
          f.seek fp - 1, IO::SEEK_SET unless @p[@pc] == 0
        when '.'
          print @p[@pc].chr
        when ','
          `stty raw -echo`
          @p[@pc] = STDIN.getc.bytes.to_a.first
          `stty -raw echo`
        when "\n"
        when "\t"
        when "\s"
        else
          f.each_line.next
        end
      end
    end
  end
end

b = Brainfuck::new
b.bf
