require_relative 'kombination'
# Main class
class Poker
  def preobraz(a, b)
    mast = { 'H' => 0, 'D' => 1, 'C' => 2, 'S' => 3 }
    card = Hash['2', 0, '3', 1, '4', 2, '5', 3, '6', 4, '7', 5, '8', 6, '9', 7,
                '10', 8, 'J', 9, 'Q', 10, 'K', 11, 'A', 12]
    @preobraz = card.key(b) + mast.key(a)
  end
  # Method for distribution of cards
  def razdacha(koloda, igrok, stol)
    schet = 0
    koloda.clear
    koloda[0] = Array.new(13) { 0 }
    koloda[1] = Array.new(13) { 0 }
    koloda[2] = Array.new(13) { 0 }
    koloda[3] = Array.new(13) { 0 }
    while schet != 7
      a = rand(4)
      b = rand(13)
      if schet < 2 && koloda[a][b].zero?
        koloda[a][b] = 1
        igrok[schet] = preobraz(a, b)
        schet += 1
      elsif schet >= 2 && koloda[a][b].zero?
        koloda[a][b] = 2
        stol[schet - 2] = preobraz(a, b)
        schet += 1
      end
    end
  end

  koloda = Array.new(4)
  igrok = Array.new(2)
  stol = Array.new(5)
  Poker.new.razdacha(koloda, igrok, stol)
  puts 'Карты игрока: ' + igrok.to_s
  puts 'Карты на столе: ' + stol.to_s
  kombination = Kombination.new

  # poker = Poker.new

  # kombo = []
  # puts 'Введите название комбинации, или нажмите Enter, чтобы продолжить'
  # begin_time = Time.now
  # # komanda = gets.chomp
  # komanda = 'Стрит'
  # if komanda == ''
  #   k = poker.razdacha(koloda, igrok, stol, poker, komanda, kombo)
  # else
  #   flag = true
  #   iter = 0
  #   while flag
  #     iter += 1
  #     next unless komanda == poker.razdacha(koloda, igrok, stol, poker,
  #                                           komanda, kombo)
  #     k = komanda
  #     flag = false
  #     time = Time.now - begin_time
  #   end
  # end
  # # output cards in console

  # puts k
  # kombina = []
  # kombo.each do |i|
  #   kombina << poker.preobraz(i[0], i[1])
  # end
  # puts kombina.to_s
  # puts 'Кол-во итераций = ' + iter.to_s
  # puts 'Время выполнения ' + time.to_s
end
