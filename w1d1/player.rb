class Player

  def initialize(name)
    @name = name
  end

  def guess
    puts "enter guess"
    guess = gets.chomp
    guess
  end

  def alert_unvalid_guess
    puts "your guess was invalid"
  end
end
