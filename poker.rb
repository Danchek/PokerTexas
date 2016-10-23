require_relative 'kombination'
# Main class
class Poker
  def transformation(a, b)
    mast = { 'H' => 0, 'D' => 1, 'C' => 2, 'S' => 3 }
    card = Hash['2', 0, '3', 1, '4', 2, '5', 3, '6', 4, '7', 5, '8', 6, '9', 7,
                '10', 8, 'J', 9, 'Q', 10, 'K', 11, 'A', 12]
    @transformation = card.key(b) + mast.key(a)
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
        igrok[schet] = transformation(a, b)
        schet += 1
      elsif schet >= 2 && koloda[a][b].zero?
        koloda[a][b] = 2
        stol[schet - 2] = transformation(a, b)
        schet += 1
      end
    end
  end

  def search(koloda, kombination, kombo)
    kombo.clear
    @search = kombination.kare(koloda, kombo)
    @search = kombination.royal(koloda, kombo) if @search.nil?
    @search = kombination.street_flash(koloda, kombo) if @search.nil?
    @search = kombination.full_house(koloda, kombo) if @search.nil?
    @search = kombination.flash(koloda, kombo) if @search.nil?
    @search = kombination.street(koloda, kombo) if @search.nil?
    @search = kombination.set(koloda, kombo) if @search.nil?
    @search = kombination.pair(koloda, kombo) if @search.nil?
    @search = kombination.great(koloda, kombo) if @search.nil?
    @search
  end

  def search_for(koloda, kombination, kombo, name)
      case name
      when 0 then @serach_for = kombination.great(koloda, kombo)
      when 1 then @serach_for = kombination.pair(koloda, kombo)
      when 2 then @serach_for = kombination.set(koloda, kombo)
      when 3 then @serach_for = kombination.street(koloda, kombo)
      when 4 then @serach_for = kombination.flash(koloda, kombo)
      when 5 then @serach_for = kombination.full_house(koloda, kombo)
      when 6 then @serach_for = kombination.street_flash(koloda, kombo)
      when 7 then @serach_for = kombination.royal(koloda, kombo)
      when 8 then @serach_for = kombination.kare(koloda, kombo)
      end
  end

  koloda = Array.new(4)
  igrok = Array.new(2)
  stol = Array.new(5)
  poker = Poker.new
  kombination = Kombination.new
  flag = true
  iter = 0
  kombo = []
  kombina = []
  if flag
    poker.razdacha(koloda, igrok, stol)
    kombo_name = poker.search(koloda, kombination, kombo)
  else
    name = rand(9)
    loop do
      iter += 1
      poker.razdacha(koloda, igrok, stol)
      kombo_name = poker.search_for(koloda, kombination, kombo, name)
      break unless kombo_name.nil?
    end
    puts 'Кол-во итераций: ' + iter.to_s
  end

  kombo.each do |i|
    kombina << poker.transformation(i[0], i[1])
  end
  puts 'Карты игрока: ' + igrok.to_s
  puts 'Карты на столе: ' + stol.to_s
  puts kombo_name.to_s
  puts kombina.to_s
end
