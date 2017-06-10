class Dice
  def initialize(faces=6, rolls=1, adds=0)
    @values = (1..faces).to_a
    @rolls = rolls
    @adds = adds
  end

  def roll(r=@rolls)
    r == 1 ? @values.sample + @adds : @values.sample + roll(r-1)
  end
end
