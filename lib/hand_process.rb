class HandProcess
  attr_reader :rank, :hand
  def initialize(hand)
    @hand = []
    @rank = 0
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

  def straight
    _stair?
  end

  def three_of_a_kind
    _three_of_a_kind
  end

  def two_pairs
    _two_pairs
  end

  def pair
    _pair
  end

  def high_card
    _high_card
  end

  def best_hand
    _best_hand
  end

  def get_second_rank(rank)
    _get_second_rank(rank)
  end

  def get_second_rank_full_house
    _get_second_rank_full_house
  end

  def get_side_card(card)
    _get_side_card(card)
  end

  private
    
  def _get_side_card(side)
    hand = []
    @hand.each do |card|
      if hand.include? card.val.to_i
         hand.delete card.val.to_i
      else
        hand << card.val.to_i
      end
    end
    hand.sort!.reverse!
    hand[side]
  end

  def _best_hand
    if straigh_flush
      return "straigh_flush"
    elsif _four_of_a_kind
      return "four_of_a_kind"
    elsif _full_house
      return "full_house"
    elsif _flush
      return "flush"
    elsif _stair?
      return "straigh"
    elsif _three_of_a_kind
      return "three_of_a_kind"
    elsif _two_pairs
      return "two_pairs"
    elsif _pair
      return "pair"
    else
      _high_card
      return "high_card"
    end
    return "error"
  end

  def _get_second_rank(rank)
    new_rank = rank
    hash = Hash.new
    @hand.each do |card| 
      hash[card.val.to_i] = hash[card.val.to_i]? hash[card.val.to_i]+1 : 1
    end

    hash.keys.each do |key|
      if hash[key] == 2
        if rank > key
          rank = key
        end
      end
    end
    rank 
  end

  def _high_card
    high = @hand.first.val.to_i
    @hand.each do |card| 
      if card.val.to_i > high
       high = card.val.to_i
      end
    end
    high 
  end

  def _pair
    hash = Hash.new
    @hand.each do |card| 
      hash[card.val.to_i] = hash[card.val.to_i]? hash[card.val.to_i]+1 : 1
    end
    
    _get_rank(hash,2)
    
    return true if hash.keys.count == 4
    return false
  end

  def _get_rank(hash,cond)

    hash.keys.each do |key|
      if hash[key] == cond
        @rank = key if @rank < key 
      end
    end
  end

  def _two_pairs
    hash = Hash.new
    @hand.each do |card| 
      hash[card.val.to_i] = hash[card.val.to_i]? hash[card.val.to_i]+1 : 1
    end
    return false if hash.keys.count != 3 
    hash.keys.each do |key|
      if hash[key] == 2
        _get_rank(hash,2)
        return true
      end
    end
    @rank = 0
    false
  end
  def _flush
    suit = @hand.first.suit
    @hand.each do |card|
      if @rank < card.val.to_i
        @rank = card.val.to_i
      end
      return false if card.suit!= suit
    end
    true
  end

  def _get_second_rank_full_house
    hash = Hash.new
    @hand.each do |card| 
      hash[card.val.to_i] = hash[card.val.to_i]? hash[card.val.to_i]+1 : 1
    end
    first, second = hash.keys
    if hash[first] == 3 and hash[second] == 2
      return second
    end
    return first
  end
  def _full_house
    hash = Hash.new
    @hand.each do |card| 
      hash[card.val.to_i] = hash[card.val.to_i]? hash[card.val.to_i]+1 : 1
    end
    return false if hash.keys.count != 2
    first, second = hash.keys
    if hash[first] == 3 and hash[second] == 2
      @rank = first
      return true
    end
    if hash[first] == 2 and hash[second] == 3
      @rank = second
      return true
    end
    return false
  end
  def _three_of_a_kind
    hash = []
    val = 0;
    @hand.each do |card| 
      hash[card.val.to_i] = hash[card.val.to_i]? hash[card.val.to_i]+1 : 1
      if hash[card.val.to_i] == 3 
        @rank = card.val.to_i
        return true 
      end
    end
    false
  end
  def _four_of_a_kind
    hash = []
    @hand.each do |card| 
      hash[card.val.to_i] = hash[card.val.to_i]? hash[card.val.to_i]+1 : 1
      if hash[card.val.to_i] == 4 
        @rank = card.val.to_i
        return true 
      end
    end
    false
  end
  def _convert(hand)
    hand.each do |card_def|
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
    @rank = arr.last
    true
  end
end

class Card
  def initialize(card_def)
    @val, @suit = card_def.split(//)
    @val = "1" if @val == 'A'
    @val = "10" if @val == 'T'
    @val = "11" if @val == 'J'
    @val = "12" if @val == 'Q'
    @val = "13" if @val == 'K'
  end
  attr_reader :val, :suit
end
