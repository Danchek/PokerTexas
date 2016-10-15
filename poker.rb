class Poker
  def preobraz(a, b)
    case a
    when 0
      mast = 'H'
    when 1
      mast = 'D'
    when 2
      mast = 'C'
    when 3
      mast = 'S'
    end

    case b
    when 0
      karta = '2'
    when 1
      karta = '3'
    when 2
      karta = '4'
    when 3
      karta = '5'
    when 4
      karta = '6'
    when 5
      karta = '7'
    when 6
      karta = '8'
    when 7
      karta = '9'
    when 8
      karta = '10'
    when 9
      karta = 'J'
    when 10
      karta = 'Q'
    when 11
      karta = 'K'
    when 12
      karta = 'A'
    end
    @preobraz = karta + mast
  end

  # Method for identification of a winnig combination
  def kombo(koloda, kombo)
    kombo_name = nil
    kombo.clear
    # Check for Kare
    for j in 0..12
      schet = 0
      for i in 0..3
        next unless koloda[i][j].nonzero?
        schet += 1
        kombo << [i, j]
        kombo_name = 'Каре' if schet == 4
      end
      kombo.clear if kombo_name.nil?
    end
    # Check for royal flash and street flash
    for i in 0..3
      if koloda[i][12].nonzero? && koloda[i][11].nonzero? &&
         koloda[i][10].nonzero? && koloda[i][9].nonzero? &&
         koloda[i][8].nonzero?
        kombo_name = 'Роял Флеш'
        kombo << [i, 12]
        kombo << [i, 11]
        kombo << [i, 10]
        kombo << [i, 9]
        kombo << [i, 8]
      end
      if kombo_name.nil?
        for j in 2..9
          next unless koloda[i][j - 2].nonzero? && koloda[i][j - 1].nonzero? &&
                      koloda[i][j].nonzero? && koloda[i][j + 1].nonzero? &&
                      koloda[i][j + 2].nonzero?
          kombo_name = 'Стрит Флеш'
          kombo << [i, j - 2]
          kombo << [i, j - 1]
          kombo << [i, j]
          kombo << [i, j + 1]
          kombo << [i, j + 2]
        end
      end
    end

    # check Full House
    if kombo_name.nil?
      k2 = -1
      k3 = -1
      for j in 0..12
        schet = 0
        for i in 0..3
          if koloda[i][j].nonzero?
            schet += 1
            kombo << [i, j]
          end
        end
        if schet >= 2
          k2 = j
        elsif schet == 3 && k3 > 0
          kombo.pop
        elsif schet == 3 && k3 == -1
          k3 = j
        elsif schet == 1
          kombo.pop
        end
      end
      kombo_name = 'Фул Хаус' if k2 != k3 && k2 > 0 && k3 > 0
    end
    #Check Flash
    if kombo_name.nil?
      for i in 0..3
        schet = 0
        for j in 12.downto(0)
          if koloda[i][j].nonzero?
            schet += 1
            kombo << [i, j]
          end
        end
        if schet == 5
          kombo_name = 'Флеш'
        elsif schet == 6
          kombo_name = 'Флеш'
          kombo.pop
        elsif schet == 7
          kombo_name = 'Флеш'
          kombo.pop
          kombo.pop
        elsif schet < 5 && kombo_name.nil?
          kombo.clear
        end
      end
    end
    # Check street
    if kombo_name.nil?
      schet = 0
      index = 0
      mas_strit = Array.new(13) { 0 }
      for j in 0..12
        for i in 0..3
          mas_strit[j] += 1 if koloda [i][j].nonzero?
        end
      end
      for i in 2..10
        next unless mas_strit[i - 2].nonzero? && mas_strit[i - 1].nonzero? &&
                    mas_strit[i].nonzero? && mas_strit[i + 1].nonzero? &&
                    mas_strit[i + 2].nonzero?
        kombo_name = 'Стрит'
        index = i
      end
      if kombo_name.nil? && mas_strit[12].nonzero? && mas_strit[0].nonzero? &&
         mas_strit[1].nonzero? && mas_strit[2].nonzero? && mas_strit[3].nonzero?
        kombo_name = 'Стрит'
        index = 12
      end
      if index.nonzero? && index != 12
        for j in (index - 2)..(index + 2)
          schet = 0
          for i in 0..3
            if schet.zero? && koloda[i][j].nonzero?
              kombo << [i, j]
              schet += 1
            end
          end
        end
      elsif index == 12
        for j in 0..3
          schet = 0
          for i in 0..3
            if schet.zero? && koloda[i][j].nonzero?
              kombo << [i, j]
              schet += 1
            end
          end
        end
        for i in 0..3
          schet = 0
          next unless schet.zero? && koloda[i][12].nonzero?
          kombo << [i, 12]
          schet += 1
        end
      end
    end
    #Check Set
    if kombo_name.nil?
      k3 = -1
      for j in 12.downto(0)
        schet = 0
        for i in 0..3
          next unless koloda[i][j].nonzero?
          schet += 1
          kombo << [i, j]
        end
        if schet == 2
          kombo.pop
          kombo.pop
        elsif schet == 3 && k3 > 0
          kombo.pop
          kombo.pop
          kombo.pop
        elsif schet == 3 && k3 == -1
          k3 = j
        elsif schet == 1
          kombo.pop
        end
      end
      kombo_name = 'Сет' if k3 > 0
    end
    # Check pair
    if kombo_name.nil?
      k2 = -1
      for j in 12.downto(0)
        schet = 0
        for i in 0..3
          next unless koloda[i][j].nonzero?
          schet += 1
          kombo << [i, j]
        end
        if schet == 2 && k2 > 0
          kombo.pop
          kombo.pop
        elsif schet == 2 && k2 == -1
          k2 = j
        elsif schet == 1
          kombo.pop
        end
      end
      kombo_name = 'Пара' if k2 >= 0
    end
    # If we don't have other combinatios then choose greatest card
    if kombo_name.nil?
      schet = 0
      for j in 12.downto(0)
        for i in 0..3
          next unless koloda[i][j].nonzero? && schet.zero?
          schet += 1
          kombo << [i, j]
        end
      end
      kombo_name = 'Старшая карта'
    end
    @kombo = kombo_name
  end

  def razdacha (koloda, igrok, stol, poker, komanda, kombo)
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
        igrok[schet] = poker.preobraz(a, b)
        schet += 1
      elsif schet >= 2 && koloda[a][b].zero?
        koloda[a][b] = 2
        stol[schet - 2] = poker.preobraz(a, b)
        schet += 1
      end
    end
    @razdacha = poker.kombo(koloda, kombo) if komanda != ''
  end
  poker = Poker.new
  koloda = Array.new(4)
  # create array with cards on the table
  igrok = Array.new(2)
  stol = Array.new(5)
  kombo = []
  puts 'Введите название комбинации, или нажмите Enter, чтобы продолжить'
  begin_time = Time.now
  # komanda = gets.chomp
  komanda = 'Стрит'
  if komanda == ''
    k = poker.razdacha(koloda, igrok, stol, poker, komanda, kombo)
  else
    flag = true
    iter = 0
    while flag
      iter += 1
      next unless komanda == poker.razdacha(koloda, igrok, stol, poker,
                                            komanda, kombo)
      k = komanda
      flag = false
      time = Time.now - begin_time
    end
  end
  # output cards in console
  puts 'Карты игрока: ' + igrok.to_s
  puts 'Карты на столе: ' + stol.to_s
  puts k
  kombina = []
  kombo.each do |i|
    kombina << poker.preobraz(i[0], i[1])
  end
  puts kombina.to_s
  puts 'Кол-во итераций = ' + iter.to_s
  puts 'Время выполнения ' + time.to_s
end
