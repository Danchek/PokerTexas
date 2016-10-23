require_relative '../poker'
require_relative '../kombination'
describe Poker do
  koloda = Array.new(4)
  igrok = Array.new(2)
  stol = Array.new(5)
  poker = Poker.new
  kombo = []
  kombination = Kombination.new
  a = 3
  b = 4

  describe '#razdacha' do
    it 'returns arrays with cards on table and in plyers hand' do
      poker.razdacha(koloda, igrok, stol)
      expect(igrok).not_to be_empty
      expect(stol).not_to be_empty
    end
  end

  describe '#transformation' do
    it 'Converts index of cards to its name' do
      expect_value = '6S'
      expect(poker.transformation(a, b)).to eq(expect_value)
    end
  end

  describe '#search' do
    it 'returns name of combination' do
      poker.razdacha(koloda, igrok, stol)
      kombo_name = poker.search(koloda, kombination, kombo)
      expect(kombo_name).to be_an(String)
    end
  end
end
