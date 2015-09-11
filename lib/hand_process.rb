class HandProcess
  def initialize(hand)
    @hand = []
    _convert(hand)
  end
  def straigh_flush
    (_same_suit? && _stair?)    
  end

  def four_of_a_kind
    _four_of_a_kind
  end

  def full_house
    _full_house
  end

  def flush
    _flush
  end

  private

  def _flush
    suit = @hand.first.suit
    @hand.each do |card|
      return false if card.suit!= suit
    end
    true
  end

  def _full_house
    hash = Hash.new
    @hand.each do |card| 
      hash[card.val.to_i] = hash[card.val.to_i]? hash[card.val.to_i]+1 : 1
    end
    return false if hash.keys.count != 2
    first, second = hash.keys
    return true if hash[first] == 3 and hash[second] == 2
    return true if hash[first] == 2 and hash[second] == 3
    return false
  end
  def _four_of_a_kind
    hash = []
    @hand.each do |card| 
      hash[card.val.to_i] = hash[card.val.to_i]? hash[card.val.to_i]+1 : 1
    end
    hash.each do |card|
      return true if card == 4
    end
    false
  end
  def _convert(hand)
    hand.split(' ').each do |card_def|
      @hand << Card.new(card_def)
    end
  end

  def _same_suit?
    suit = @hand.first.suit
    @hand.each do |card|
      return false if card.suit != suit
    end
    return true
  end

  def _stair?
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
    @val = "10" if @val == 'T'
    @val = "11" if @val == 'J'
    @val = "12" if @val == 'Q'
    @val = "13" if @val == 'K'
  end
  attr_reader :val, :suit
end
