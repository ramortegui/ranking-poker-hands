require 'hand_process'
class HandEvaluator
  def return_stronger_hand(left, right)
    hand1 = HandProcess.new(left)
    hand2 = HandProcess.new(right)
    value = _compare(hand1.best_hand,hand2.best_hand)
    if value == 1
      return left
    elsif value == 2
      return right
    else
      if(hand1.rank < hand2.rank)
        return right
      elsif(hand1.rank > hand2.rank)
        return left
      else
        if(hand1.best_hand == 'two_pairs')
          s_rank1 =  hand1.get_second_rank(hand1.rank)
          s_rank2 = hand2.get_second_rank(hand2.rank)
          if s_rank1 < s_rank2
            return right
          elsif s_rank1 > s_rank2
            return left
          end
        elsif(hand1.best_hand == 'full_house')
          s_rank1 =  hand1.get_second_rank_full_house
          s_rank2 = hand2.get_second_rank_full_house
          if s_rank1 < s_rank2
            return right
          else s_rank1 > s_rank2
            return left
          end
        end
        side_card = 3
        while(side_card > 0)do
          s_side1 =  hand1.get_side_card(3-side_card)
          s_side2 = hand2.get_side_card(3-side_card)
          if s_side1 < s_side2
            return right
          else s_side1 > s_side2
            return left
          end
          side_card -= 1
        end

        return left
      end
    end


  end

  private
  def _compare (str1,str2)
    val1 = _get_value(str1)
    val2 = _get_value(str2)
    if val1 > val2 
      return 1
    elsif val2 > val1
      return 2
    elsif val1 == val2
      return 0
    end
  end

  def _get_value(str)
    case str
    when "straigh_flush"
      return 9
    when "four_of_a_kind"
      return 8
    when "full_house"
      return 7
    when "flush"
      return 6
    when "straigh"
      return 5
    when "three_of_a_kind"
      return 4
    when "two_pairs"
      return 3
    when "pair"
      return 2
    when "high_card"
      return 1
    else
      return 0
    end
  end
end
