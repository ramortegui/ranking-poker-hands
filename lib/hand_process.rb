class HandProcess
  def initialize(hand)
    @hand = []
    convert(hand)
  end
  def straigh_flush
    (same_sign? && stair?)    
  end

  private

  def convert(hand)
    hand.split(' ').each do |card_def|
      @hand << Card.new(card_def)
    end
  end

  def same_sign?
    sign = @hand.first.sign
    @hand.each do |card|
      return false if card.sign != sign 
    end
    return true
  end

  def stair?
    arr = []
    @hand.each do |card| 
      arr << card.val.to_i
    end
    arr.sort!
    ant = arr.first-1
    arr.each do |val|
      return false unless ant+1 == val 
      ant += 1
    end
    true
  end
end

class Card
  def initialize(card_def)
    @val, @sign = card_def.split(//)
    @val = "10" if @val == 'J'
    @val = "11" if @val == 'Q'
    @val = "12" if @val == 'K'
  end
  attr_reader :val, :sign 
end
