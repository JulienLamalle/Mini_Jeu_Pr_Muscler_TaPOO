require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

class App < Player

  player1 = Player.new("Josiane")
  player2 = Player.new("José")

  #Start
  puts "Ok, on est parti !"
  puts "Voici nos deux combattants : à ma droite #{player1.name}, de l'autre coté c'est #{player2.name} qui va se battre aujourd'hui "

  while player1.life_points > 0 && player2.life_points > 0 do
    puts "Voici la forme de chacun de nos joueurs :"
    puts player1.show_state
    puts player2.show_state
    puts ""
    puts " ----------- Let's go to the rumble ----------- :"
    puts ""
    puts player1.attacks(player2)
      break if player2.life_points <= 0 #It's the end of the game if a player dies
    player2.attacks(player1)
  end
end

