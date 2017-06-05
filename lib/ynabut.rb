require_relative 'dice'
class Ynabut
  def initialize
    @stability = 3
  end
  def answer(likelihood=50)
    result = 0
    @stability.times {
      result += Dice.new(100,1).roll
      puts result
    }
    result /= @stability
    puts result
    if result < likelihood / 2
      puts "Yes and..."
    elsif result <= likelihood * 3/4
      puts "Yes"
    elsif result <= likelihood
      puts "Yes, but"
    elsif result > likelihood * 2
      puts "No and"
    elsif result > likelihood * 4/3
      puts "No, but"
    else
      puts "No"
    end
  end
  def inc_chaos
    @stability == 1 ? @stability : @stability -= 1
  end
  def dec_chaos
    @stability > 6 ? @stability : @stability += 1
  end
end
