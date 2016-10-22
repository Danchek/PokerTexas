class Kombination
 # Check for Kare
  def kare(koloda, kombo, kombo_name)
    (0..12).each do |j|
      schet = 0
      (0..3).each do |i|
        next unless koloda[i][j].nonzero?
        schet += 1
        kombo << [i, j]
        kombo_name = 'Каре' if schet == 4
      end
      kombo.clear if kombo_name.nil?
    end
  end

  # Check for royal flash and street flash
  def royal_street(koloda, kombo, kombo_name)
    (0..3).each do |i|
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
      next unless kombo_name.nil?
      (2..9).each do |j|
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
    kombo.clear if kombo_name.nil?
  end

  # check Full House
  def full_house(koloda, kombo, kombo_name)
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
    kombo.clear if kombo_name.nil?
  end

  # Check Flash
  def flash(koloda, kombo, kombo_name)
    (0..3).each do |i|
      schet = 0
      12.downto(0).each do |j|
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
    kombo.clear if kombo_name.nil?
  end

  # Check street
  def street (koloda, kombo, kombo_name)
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
      kombo_name = 'Стрит'
      index = i
    end
    if kombo_name.nil? && mas_strit[12].nonzero? && mas_strit[0].nonzero? &&
       mas_strit[1].nonzero? && mas_strit[2].nonzero? && mas_strit[3].nonzero?
      kombo_name = 'Стрит'
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
    kombo.clear if kombo_name.nil?
  end

  # Check Set
  def set (koloda, kombo, kombo_name)
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
    kombo_name = 'Сет' if k3 > 0
    kombo.clear if kombo_name.nil?
  end

  # Check pair
  def pair(koloda, kombo, kombo_name)
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
    kombo_name = 'Пара' if k2 >= 0
    kombo.clear if kombo_name.nil?
  end

  # If we don't have other combinatios then choose greatest card
  def great(koloda, kombo, kombo_name)
    schet = 0
    12.downto(0).each do |j|
      (0..3).each do |i|
        next unless koloda[i][j].nonzero? && schet.zero?
        schet += 1
        kombo << [i, j]
      end
    end
    kombo_name = 'Старшая карта'
    kombo.clear if kombo_name.nil?
  end
end
