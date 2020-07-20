require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts "
                      --------------------------------------------------
                      | Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |
                      | Le but du jeu est de ne pas leur la donner !   |
                      --------------------------------------------------  "

puts " 
888888b.                     888         888    888                             
888   88b                    888         888    888                             
888  .88P                    888         888    888                             
8888888K.   .d88b.   8888b.  888888      888888 88888b.   .d88b.  88888b.d88b.  
888   Y88b d8P  Y8b      88b 888         888    888  88b d8P  Y8b 888  888  88b 
888    888 88888888 .d888888 888         888    888  888 88888888 888  888  888 
888   d88P Y8b.     888  888 Y88b.       Y88b.  888  888 Y8b.     888  888  888 
8888888P     Y8888   Y888888   Y888        Y888 888  888   Y8888  888  888  888 

"

puts "Quel est ton nom ?"
name_of_human_player = gets.chomp.to_s
puts "Salut #{name_of_human_player}"

my_game = Game.new(name_of_human_player)

while my_game.is_still_ongoing?
  my_game.new_players_in_sight
  my_game.menu
  my_game.menu_choice
    my_game.show_players
    my_game.enemies_attack
    my_game.show_players
end
my_game.end