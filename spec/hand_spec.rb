require "spec_helper"
require "hand_process"

describe HandProcess do
  describe "straight flush" do
    it "has a straigth flush" do
       hand_process  = HandProcess.new("3S 2S 4S 5S 6S")
       expect(hand_process.straigh_flush).to be true
    end
    it "doesn't  has a straigth flush" do
       hand_process  = HandProcess.new("5S 2S 4S 4S 5D")
       expect(hand_process.straigh_flush).to be false 
    end
  end
  describe "four of a kind" do
    it "has four of a kind" do
      hand_process = HandProcess.new("1S 2P 1A 1H 1T")
      expect(hand_process.four_of_a_kind).to be true
    end
    it "doesn't have four of a kind" do
      hand_process = HandProcess.new("1S 2P 3A 1H 1T")
      expect(hand_process.four_of_a_kind).to be false 
    end
  end
  describe "full house" do
    it "has full house" do
      hand_process = HandProcess.new("KH KT KE TC TD")
      expect(hand_process.full_house).to be true
    end
    it "doesn't have full house" do
      hand_process = HandProcess.new("AH KT KE TC TD")
      expect(hand_process.full_house).to be false
    end
  end
  describe "flush" do
    it "has flush" do
      hand_process = HandProcess.new("AH KH KH TH TH")
      expect(hand_process.flush).to be true
    end
    it "doesn't have flush" do
      hand_process = HandProcess.new("AD KH KH TH TH")
      expect(hand_process.flush).to be false
    end
  end
end