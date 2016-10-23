require_relative '../kombination'

describe Kombination do
  kombo = []
  kombination = Kombination.new
  koloda = Array.new(4)
  koloda[0] = Array.new(13) { 0 }
  koloda[1] = Array.new(13) { 0 }
  koloda[2] = Array.new(13) { 0 }
  koloda[3] = Array.new(13) { 0 }

  context '#kare' do
    koloda[0][1] = koloda[1][1] = koloda[2][1] = koloda[3][1] = koloda[2][5] = 1
    koloda[3][6] = koloda[2][8] = 2
    it 'returns name of kombination and array with cards in combintaion' do
      kombo_name = kombination.kare(koloda, kombo)
      expect(kombo_name).to eq('Каре')
      expect(kombo).to contain_exactly([0, 1], [1, 1], [2, 1], [3, 1])
    end
  end

  context '#royal' do
    koloda[0][12] = koloda[0][11] = koloda[0][10] = koloda[0][9] =
      koloda[0][8] = 1
    koloda[3][6] = koloda[2][8] = 2
    it 'returns name of kombination and array with cards in combintaion' do
      kombo_name = kombination.royal(koloda, kombo)
      expect(kombo_name).to eq('Роял Флеш')
      expect(kombo).to contain_exactly([0, 12], [0, 11], [0, 10], [0, 9],
                                       [0, 8])
    end
  end

  context '#street_flash' do
    koloda[0][0] = koloda[0][1] = koloda[0][2] = koloda[0][3] = koloda[0][4] = 1
    koloda[3][6] = koloda[2][8] = 2
    it 'returns name of kombination and array with cards in combintaion' do
      kombo_name = kombination.street_flash(koloda, kombo)
      expect(kombo_name).to eq('Стрит Флеш')
      expect(kombo).to contain_exactly([0, 0], [0, 1], [0, 2], [0, 3], [0, 4])
    end
  end
end

describe Kombination do
  kombo = []
  kombination = Kombination.new
  koloda = Array.new(4)
  koloda[0] = Array.new(13) { 0 }
  koloda[1] = Array.new(13) { 0 }
  koloda[2] = Array.new(13) { 0 }
  koloda[3] = Array.new(13) { 0 }

  context '#full_house' do
    koloda[0][0] = koloda[1][0] = koloda[2][0] = koloda[0][1] = koloda[1][1] = 1
    koloda[2][6] = koloda[2][8] = 2
    it 'returns name of kombination and array with cards in combintaion' do
      kombo_name = kombination.full_house(koloda, kombo)
      expect(kombo_name).to eq('Фул Хаус')
      expect(kombo).to contain_exactly([0, 0], [1, 0], [2, 0], [0, 1], [1, 1])
    end
  end
end

describe Kombination do
  kombo = []
  kombination = Kombination.new
  koloda = Array.new(4)
  koloda[0] = Array.new(13) { 0 }
  koloda[1] = Array.new(13) { 0 }
  koloda[2] = Array.new(13) { 0 }
  koloda[3] = Array.new(13) { 0 }

  context '#flash' do
    koloda[3][0] = koloda[3][2] = koloda[3][5] = koloda[3][7] = koloda[3][9] = 1
    koloda[2][6] = koloda[2][8] = 2
    it 'returns name of kombination and array with cards in combintaion' do
      kombo_name = kombination.flash(koloda, kombo)
      expect(kombo_name).to eq('Флеш')
      expect(kombo).to contain_exactly([3, 0], [3, 2], [3, 5], [3, 7], [3, 9])
    end
  end

  describe '#street' do
    koloda[1][1] = koloda[1][3] = koloda[2][4] = koloda[0][9] =
      koloda[0][8] = 1
    koloda[2][6] = koloda[2][8] = 2
    it 'returns name of kombination and array with cards in combintaion' do
      kombo_name = kombination.street(koloda, kombo)
      expect(kombo_name).to eq('Стрит')
      expect(kombo).to contain_exactly([0, 8], [0, 9], [2, 6], [3, 5], [3, 7])
    end
  end
end

describe Kombination do
  kombo = []
  kombination = Kombination.new
  koloda = Array.new(4)
  koloda[0] = Array.new(13) { 0 }
  koloda[1] = Array.new(13) { 0 }
  koloda[2] = Array.new(13) { 0 }
  koloda[3] = Array.new(13) { 0 }

  describe '#set' do
    koloda[0][12] = koloda[1][12] = koloda[2][12] = koloda[0][9] =
      koloda[0][8] = 1
    koloda[3][6] = koloda[2][8] = 2
    it 'returns name of kombination and array with cards in combintaion' do
      kombo_name = kombination.set(koloda, kombo)
      expect(kombo_name).to eq('Сет')
      expect(kombo).to contain_exactly([0, 12], [1, 12], [2, 12])
    end
  end
end

describe Kombination do
  kombo = []
  kombination = Kombination.new
  koloda = Array.new(4)
  koloda[0] = Array.new(13) { 0 }
  koloda[1] = Array.new(13) { 0 }
  koloda[2] = Array.new(13) { 0 }
  koloda[3] = Array.new(13) { 0 }

  describe '#pair' do
    koloda[0][12] = koloda[1][12] = koloda[2][11] = koloda[0][9] =
      koloda[0][9] = 1
    koloda[3][6] = koloda[2][8] = 2
    it 'returns name of kombination and array with cards in combintaion' do
      kombo_name = kombination.pair(koloda, kombo)
      expect(kombo_name).to eq('Пара')
      expect(kombo).to contain_exactly([0, 12], [1, 12])
    end
  end

  describe '#great' do
    it 'returns name of kombination and array with cards in combintaion' do
      kombo_name = kombination.great(koloda, kombo)
      expect(kombo_name).to eq('Старшая карта')
      expect(kombo).to contain_exactly([0, 12])
    end
  end
end
