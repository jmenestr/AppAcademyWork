require './player'
require 'byebug'
require 'colorize'
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
      p "#{players.first} has won!"
  end

  private
    def next_player
      first_player = players.shift
      @players += [first_player]
    end

    def current_player
      players.first
    end

    def take_turn(player)
      system("clear")
      display_status
      puts "Current fragment is: #{fragment}"
      puts "#{player}, please enter your guess".colorize(:green)
      turn = player.guess
      until valid_play?(turn)
        player.alert_unvalid_guess
        turn = player.guess
      end

      update_fragment(turn)

      if frag_is_word?
        update_losses
      end

      next_player

      #check valid move
      #if valid, update fragment
    end

    def update_fragment(turn)
      @fragment += turn
    end

    def update_losses
      @losses[current_player] += 1
      @fragment = ""
      if @losses[current_player] == 5
        players.shift
      end
    end

    def frag_is_word?
      dictionary.include?(@fragment)
    end

    def display_status
      players.each do |player|
        puts "#{player}: #{"GHOST".slice(0...@losses[player])}"
      end
    end

    def winner?
       players.length == 1
    end

    def valid_play?(turn)
      check = fragment + turn
      #This may take a while to iternate through the entire dicionary
      #implement with set and .select!/include?
      ("a".."z").include?(turn) && dictionary.any? do  |word|
        word.start_with?(check)
      end
    end

end

Game.new(Player.new("Justin"),Player.new('Kristen"'),Player.new("Bob")).play_round
