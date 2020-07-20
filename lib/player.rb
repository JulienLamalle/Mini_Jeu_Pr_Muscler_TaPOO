class Player
  attr_accessor :name, :life_points

  #Initialize a new player
  def initialize(name)
    @name = name 
    @life_points = 10
  end

  #to show the player's life points
  def show_state
    puts "#{@name} a #{@life_points} points de vie"
  end

  #to reduce life points according to the received damage
  def gets_damage(damage)
    @life_points = @life_points - damage
    if @life_points <=  0
      puts "le joueur #{@name} a été tué !"
    end
  end

  #to perform the attack 
  def attacks(player_attacked)
    puts " Le joueur #{@name} attaque le joueur #{player_attacked.name}"
    the_attack = compute_damage #use of method compute_damage to calculate the number of damage
    puts "#{@name} attaque #{player_attacked.name} et lui inflige #{the_attack} points de dommages "
    player_attacked.gets_damage(the_attack)
  end

  #to randomly choose the damage
  def compute_damage
    return rand(1..6)
  end
end


class HumanPlayer < Player
  attr_accessor :weapon_level

  #as for the player
  def initialize(name)
    @name = name
    @life_points = 100
    @weapon_level = 1
  end

  #as for the player
  def show_state
    puts "#{@name} a #{@life_points} points de vie et a une arme de niveau #{@weapon_level}"
  end

  #as for the player but by adding the weapon level variable which will multiply by the random choice of damage
  def compute_damage
    rand(1..6) * @weapon_level
  end

  #to search a new weapon with bigger level (or not...)
  def search_weapon
    new_level = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{new_level}"
    if new_level > @weapon_level 
      @weapon_level = new_level
      puts "Là gros ton arme est clairement plus forte, on l'échange avec l'ancienne"
    else 
      puts "Laisse tomber, c'est pas mieux que ce que tu as déjà on oubli cette arme"
    end
  end

  #to search a health pack for Human player
  def search_health_pack
    health_pack = rand(1..6)
    if health_pack == 1
      puts "Tu n'as rien trouvé..."
    elsif health_pack == [2..5] 
      if @life_points + 50 >= 100 
        @life_points = 100
      else 
        @life_points = @life_points + 50
      end
      puts "GG, tu as trouvé un pack de +50 points de vie"
      puts "Tu as désormais #{@life_points} points de vie."
    else 
      if @life_points + 80 >= 100
        @life_points = 100
      else
        @life_points = @life_points + 80
      end
      puts "GG, tu as trouvé un pack de +80 points de vie"
      puts "Tu as désormais #{@life_points} points de vie."
    end
  end
end
