class HandProcess
  def initialize(hand)
    @hand = []
    convert(hand)
  end
  def straigh_flush
    (same_suit? && stair?)    
  end

  private

  def convert(hand)
    hand.split(' ').each do |card_def|
      @hand << Card.new(card_def)
    end
  end

  def same_suit?
    suit = @hand.first.suit
    @hand.each do |card|
      return false if card.suit != suit
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
    @val, @suit = card_def.split(//)
    @val = "11" if @val == 'J'
    @val = "12" if @val == 'Q'
    @val = "13" if @val == 'K'
  end
  attr_reader :val, :suit
end
