require_relative '../lib/dice'
describe Dice do
  describe '#roll' do
    10.times do
      it 'rolls a six sided dice when given no arguments' do
        expect(Dice.new.roll).to be <=6
        expect(Dice.new.roll).not_to be < 1
      end
    end
    10.times do
      it 'rolls a 12 sided dice when given argument 12' do
        expect(Dice.new(12).roll).to be <= 12
      end
    end
    100.times do
      it 'rolls a 3d6' do
        expect(Dice.new(6,3).roll).to be <= 18
        expect(Dice.new(6,3).roll).to be > 2
      end
    end
    100.times do
      it 'rolls a 2d6+1' do
        expect(Dice.new(6,2,1).roll).to be <= 13
        expect(Dice.new(6,2,1).roll).to be > 2
      end
    end
  end
end
