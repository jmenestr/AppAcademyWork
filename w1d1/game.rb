require './player'
require 'byebug'
class Game
  attr_accessor :current_player, :fragment, :losses, :players
  attr_reader :dictionary

  def initialize *players
    @players = players
    @current_player = players.first
    @previous_player = players.last
    @dictionary = File.readlines('dictionary.txt').map(&:chomp)
    @losses = {}
    players.each  {|player| @losses[player] = 0}
    @fragment = ""
  end

  def play_round
    #initiates the turn
    #switches player
      take_turn(current_player) until winner?
      next_player
  end

  def next_player
    first_player = players.shift
    players += [first_player]
  end

  def current_player
    players.first
  end

  def take_turn(player)
    puts fragment
    turn = player.guess
    until valid_play?(turn)
      player.alert_unvalid_guess
      turn = player.guess
    end

    @fragment += turn

    if dictionary.include?(fragment)
      @losses[current_player] += 1
      @fragment = ""
      if @losses[current_player] == 5
        players.shift
      end
    end

    #check valid move
    #if valid, update fragment
  end

  def winner?
    players.length == 1
  end

  def valid_play?(turn)
    check = fragment + turn
    #This may take a while to iternate through the entire dicionary
    #implement with set and .select!/include?
    a = dictionary.select do  |word|
      word[0...(check).length] == check
    end
    ("a".."z").include?(turn) && dictionary.any? do  |word|
      word.start_with?(check)
    end
  end

end

Game.new(Player.new("a"),Player.new('b"')).play_round
