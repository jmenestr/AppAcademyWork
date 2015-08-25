class Player

  def initialize(name)
    @name = name
  end

  def guess
    guess = gets.chomp
    guess
  end

  def alert_unvalid_guess
    puts "your guess was invalid"
  end

  def to_s
    @name
  end

end
