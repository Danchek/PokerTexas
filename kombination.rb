class Kombination
  # Check for Kare
  def kare(koloda, kombo)
    kombo.clear
    (0..12).each do |j|
      schet = 0
      (0..3).each do |i|
        next unless koloda[i][j].nonzero?
        schet += 1
        kombo << [i, j]
        @kare = 'Каре' if schet == 4
      end
      break unless @kare.nil?
      kombo.clear
    end
    @kare
  end

  # Check for royal flash
  def royal(koloda, kombo)
    kombo.clear
    (0..3).each do |i|
      next unless koloda[i][12].nonzero? && koloda[i][11].nonzero? &&
                  koloda[i][10].nonzero? && koloda[i][9].nonzero? &&
                  koloda[i][8].nonzero?
      @royal_street = 'Роял Флеш'
      kombo << [i, 12]
      kombo << [i, 11]
      kombo << [i, 10]
      kombo << [i, 9]
      kombo << [i, 8]
    end
    @royal_street
  end

  # Check for street flash
  def street_flash(koloda, kombo)
    kombo.clear
    (0..3).each do |i|
      (2..9).each do |j|
        next unless koloda[i][j - 2].nonzero? && koloda[i][j - 1].nonzero? &&
                    koloda[i][j].nonzero? && koloda[i][j + 1].nonzero? &&
                    koloda[i][j + 2].nonzero?
        @street_flash = 'Стрит Флеш'
        kombo << [i, j - 2]
        kombo << [i, j - 1]
        kombo << [i, j]
        kombo << [i, j + 1]
        kombo << [i, j + 2]
      end
    end
    @street_flash
  end

  # check Full House
  def full_house(koloda, kombo)
    kombo.clear
    k2 = -1
    k3 = -1
    (0..12).each do |j|
      schet = 0
      (0..3).each do |i|
        if koloda[i][j].nonzero?
          schet += 1
          kombo << [i, j]
        end
      end
      if schet == 3 && k3 == -1
        k3 = j
      elsif schet == 3 && k3 > 0
        kombo.pop
      elsif schet == 2
        k2 = j
      elsif schet == 1
        kombo.pop
      end
    end
    @full_house = 'Фул Хаус' if k2 != k3 && k2 >= 0 && k3 >= 0
    @full_house
  end

  # Check Flash
  def flash(koloda, kombo)
    kombo.clear
    (0..3).each do |i|
      schet = 0
      12.downto(0).each do |j|
        if koloda[i][j].nonzero?
          schet += 1
          kombo << [i, j]
        end
      end
      if schet == 5
        @flash = 'Флеш'
      elsif schet == 6
        @flash = 'Флеш'
        kombo.pop
      elsif schet == 7
        @flash = 'Флеш'
        kombo.pop
        kombo.pop
      elsif schet < 5 && @flash.nil?
        kombo.clear
      end
    end
    @flash
  end

  # Check street
  def street (koloda, kombo)
    kombo.clear
    schet = 0
    index = 0
    mas_strit = Array.new(13) { 0 }
    (0..12).each do |j|
      (0..3).each do |i|
        mas_strit[j] += 1 if koloda [i][j].nonzero?
      end
    end
    (2..10).each do |i|
      next unless mas_strit[i - 2].nonzero? && mas_strit[i - 1].nonzero? &&
                  mas_strit[i].nonzero? && mas_strit[i + 1].nonzero? &&
                  mas_strit[i + 2].nonzero?
      @street = 'Стрит'
      index = i
    end
    if @street.nil? && mas_strit[12].nonzero? && mas_strit[0].nonzero? &&
       mas_strit[1].nonzero? && mas_strit[2].nonzero? && mas_strit[3].nonzero?
      @street = 'Стрит'
      index = 12
    end
    if index.nonzero? && index != 12
      ((index - 2)..(index + 2)).each do |j|
        schet = 0
        (0..3).each do |i|
          if schet.zero? && koloda[i][j].nonzero?
            kombo << [i, j]
            schet += 1
          end
        end
      end
    elsif index == 12
      (0..3).each do |j|
        schet = 0
        (0..3).each do |i|
          if schet.zero? && koloda[i][j].nonzero?
            kombo << [i, j]
            schet += 1
          end
        end
      end
      (0..3).each do |i|
        schet = 0
        next unless schet.zero? && koloda[i][12].nonzero?
        kombo << [i, 12]
        schet += 1
      end
    end
    @street
  end

  # Check Set
  def set (koloda, kombo)
    kombo.clear
    k3 = -1
    12.downto(0).each do |j|
      schet = 0
      (0..3).each do |i|
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
    @set = 'Сет' if k3 > 0
    @set
  end

  # Check pair
  def pair(koloda, kombo)
    kombo.clear
    k2 = -1
    12.downto(0).each do |j|
      schet = 0
      (0..3).each do |i|
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
    @pair = 'Пара' if k2 >= 0
    @pair
  end

  # If we don't have other combinatios then choose greatest card
  def great(koloda, kombo)
    kombo.clear
    schet = 0
    12.downto(0).each do |j|
      (0..3).each do |i|
        next unless koloda[i][j].nonzero? && schet.zero?
        schet += 1
        kombo << [i, j]
      end
    end
    @great = 'Старшая карта'
    @great
  end
end
