require_relative '../poker'
describe Poker do
  poker = Poker.new
  komanda = 'Стрит'
  koloda = Array.new(4)
  igrok = Array.new(2)
  stol = Array.new(5)
  kombo = []
  a = 2
  b = 4

  describe '#razdacha' do
    it 'returns name of combination' do
      expect(poker.razdacha(koloda, igrok, stol, poker, komanda, kombo)).not_to
      be_empty
      expect(kombo).not_to be_empty
    end
  end

  describe '#preobraz' do
    it 'Converts index of cards to its name' do
      expect_value = '6C'
      expect(poker.preobraz(a, b)).to eq(expect_value)
    end
  end

  describe '#kombo' do
    it 'returns name of combination' do
      expect(poker.razdacha(koloda, igrok, stol, poker, komanda, kombo)).not_to
      be_empty
      expect(kombo).not_to be_empty
    end
  end
end
