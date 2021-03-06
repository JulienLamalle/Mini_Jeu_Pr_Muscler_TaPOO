
class Game
  attr_accessor :human_player, :enemies
  

  def initialize(human)
    @human_player = HumanPlayer.new(human)
    @enemies_in_sight = Array.new
    @players_left = 10
  end

  def kill_player
    #remove an enemy who died from the enemy board
    @enemies_in_sight.each do |enemy|
      if enemy.life_points <= 0
        @enemies_in_sight.delete(enemy)
      end
    end
  end

  def is_still_ongoing?
    if @human_player.life_points > 0 && (@players_left != 0 || @enemies_in_sight.length != 0)
      return true
    else
      return false
    end
  end

  def show_players
    puts "#{@human_player.show_state}"
    puts "Il te reste #{@enemies_in_sight.length + @players_left} bot(s) à vaincre"
  end

  def menu 
    puts "Quelle action veux-tu effectuer ?"
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner "
    puts ""
    puts "Attaquer un des bots encore en vie : "
    i = 0
    @enemies_in_sight.each do |enemy|
      if enemy.life_points > 0
        puts "Tu peux sinon attaquer l'ennemi #{i}"
        enemy.show_state
        i = i + 1
      end
    end
  end

  def menu_choice()
    puts "Quel est ton choix ?"
    user_choice = gets.chomp.to_s
    puts " "
    if user_choice == "a"
      @human_player.search_weapon
    elsif user_choice == "s"
      @human_player.search_health_pack
    elsif user_choice == "0" || user_choice == "1" || user_choice == "2" || user_choice == "3"
      position = user_choice.to_i
      if position <= @enemies_in_sight.count-1  #select the enemy to attack
        if @enemies_in_sight[position].life_points > 0
          @human_player.attacks(@enemies_in_sight[position])
          kill_player #will suppress the enemy if it has 0 lifepoints following the attack suffered
        end
      else 
        puts "Il n'est pas mort de ton attaque, la partie continue"
      end
    else 
      puts "Tu n'as pas saisie de commande correct ! Pour cette fois tu passes ton tour !!!"
    end
  end

  def enemies_attack
    puts "--------------! Les ennemies contre-attaquent !--------------"
    puts ""
    @enemies_in_sight.each do |enemy|
      enemy.attacks(@human_player)
    end
  end

  def new_players_in_sight
    if @players_left == 0
      puts "Tout les joueurs sont déjà en vue !"
    else
      new_enemy_or_not = rand(1..6) 
      if new_enemy_or_not == 1
        puts "Aucun nouvel ennemi en vu"
      elsif new_enemy_or_not == [2..4]
        random_name = 'player' + rand(0..1000).to_s
        puts "Un nouvel ennemi est entré dans notre champ de vision"
        new_enemy = Player.new(random_name)
        @enemies_in_sight << new_enemy
        @players_left -=1
      else new_enemy_or_not == [5..6]
        random_name = "player" + rand(0..1000).to_s
        random_name2 = "player" + rand(0..1000).to_s
        puts "2 nouveaux ennemis sont dans notre champ de vision "
        new_enemy = Player.new(random_name)
        new_enemy2 = Player.new(random_name2)
        @enemies_in_sight << new_enemy
        @enemies_in_sight << new_enemy2
        @players_left -=2
      end
    end
  end

  def end
    puts "La partie est finie"
    if @human_player.life_points > 0
      puts "GG, t'as fumé ces putains de robots "
      puts "                                                                                                  
                            %@@@@@&,                                                                  
                          #&@@@@@&@&&(                                                                
                          @%@@@(,...,,%                                                                
                        @@&@@%*.   ..,       .   ,*.                                          */,.    
                        #/@&*,,%@@(.,*   .*(/*&@#,                                           .,*/*,   
                        */.....  ,*,*/ //(&&@@@#.                                           *#&%#/*,  
                        #@#%. .,*/.,/%.(#&@&&@&                                             ((////*/*  
                      ,,@(.  .,(@@./&%@%@@./   ..,,                        ,     . ,# ,.,/(%%((/(   
                      ...,,,,,/*,,.#,&&@@@@%,  ,. &%/,,,*                   (%@@     ##**,%%%&&&((   
                    ...**(%&@@&/ ./@@@@@@#% ,   .,.,#***                ,&@@@@@@&.* .*%((&&&&/#%#&    
                  ,..,*(#@@#(&@@@@@@@@@&,..,*(/  **./%(                 //#@@@&&,..**&%&@@@@&%&     
            (**/(#,,,(#(&&@@%/.  *%*(@@((%&@#%, .*/@&*           .,///(/@@@@%,*(%@@@&@@@@&@//##      
          ,...(#*,,(&&&        . *.  .///*#(,.,.*#@(  */********/((%((@@@@@@@@@@@@@@@&%&.,/((.      
          ,.../(..,(@@#.            .//,  ,/#%/((*.#&&*,*/((//////((#@@&@@@@@@@@@@@@@@@%#%@@%#&(       
          ,,**.. ,#@/     ..   ., . .(@@#. .*     .****/((##&%#&%&&&@@&@@@@@@@@@@@@,   ##. (/&/        
          ,*....*%@,..     . .     (% @@@#,..*  .,,*/(#%&@@@@@@@@&&&@&@@@@@@@@@@@,         ( (         
        ,.  .,/%@*....*/###*..   *,&%&@@@#,..,*,*/#%&@@@@@@@@@@@@@@&@@@@@@@@                          
          .,*(%@#(&&,   .  .  ,*,.*@%@@&(/*,*/%&&@@@@@@@@@@&&@@&@@@@@@%                           
        ..*(#&@@&.     ,,         ,/(@/ ##(///#%&&@@@@@@@@@@@@&&&&%@@@#                               
          .&@.*@%*,(               ..*. (///(#%&&&&@@@@@@@@@@@@@@@@@@                                  
              ,,&,               ./&@&%(//(&%&&&@@@@@@@@@@@@@@@@@@                                     
                  /      (&&&%&&%&&#% &&@@@@@@@@@@@@@@@*,                                         
                .     (%&&%&%#&&&%&(%&&@@@@@@@@@@@@@#                                               
                    (%(##((&#&%&&&&%@@@@@@@@@@@@@@#                                                 
                    ((####%#&&(#&&&@&@@@@@@@@@@@@@@%                                                   
                  /##%&&%&&%(&&@@@@@@@@@@@@@@@@@@,                                                    
                  /(%&%#@%@&&@@@@@@@@@@@@@@@@@.                                                     
                  /%#&%&@%#@@@@@@@@@@@@@@@@@(                                                       
                  /(###&&(((%@@@@@@@@@@@@@@@&                                                         
                  #(##((/#%&@@@@@@@@@@@@@@*                                                           
                  /(#//(#%&%@@@@@@@@@@@*                                                              
                ,@#/*/###@&&@@@@@@@@@,                                                                
                @##*/#%/&@&@@@@@@@@,                                                                  
                @*#/#%(/@@#%@@@@@@                                                                    
                  ,%(##*%@@#&@@@@@&                                                                    
                  *%(#(/@@@@@@@@                                                                     
                  /%((/#@@%#@@@@@@                                                                     
                  #&((/&@@#%@@@@@@                                                                     
                  ###((@@@#&@@@@@*                                                                     
                  (%((%@@&@@@@.                                                                      
                  /(@@@&%&@@@%                                                                       
                  (#(%@@@@&@@@@                                                                        
                  &%&@@@@@@@@@*                                                                        
                  @&@@@@@@@@@.                                                                        
                  @@@&&@@@@@                                                                        
                  .%@&@@&&@@@@@                                                                       
                    %@&@@&%@@@@@&                                                                      
                    /@@@@@%@@@@@@%                                                                     
                    .@@@@@%@@@@@@@&                                                                    
                    @@@@@&&@@@@@@@%                                                                   
                    @@@@@@&&&&&@@&%                                                                   
                    .@@@@@@@&@&&&*                                                                  
                    .@@@@@@@@@@@@@@#,                                                                 
                    ,@@@@@@@@@@@@@@@&                                                                 
                    .@@@@@@@@@@@@@@@&,                                                                
                      @@@@@@@@@@@@@@@&(                                                                
                      @@@@@@@@@@@@@@@&%/&                                                              
                      %,@,   @@&(&,&/%@                                                              
                      #@  (/*%@,**&%&&&                                                             
                      ,*#&&&%&&%/%&&@@%@* "
    else
      puts "LOOOOOOSER! Tu as perdu"
      puts '
                                                                                                                . .     
                                                      .*,,,.                                                             
                                                  , //,.     /...                                                        
                                                  */.,    .   *, ,                                                       
                                                %//*    . ...,., .                                                      
                                                #%,*.      ,,  *,                                                        
                                              %  ,*  ,/***/..(%.*                                                       
                                              ,* .,.*/% /./.,*(  .                                                      
                                              ,   ,.   ,.,,/,/ **. ,                                                     
                                          .,.     /..****,#%,.,,.,.,,                                                   
                                          ..       ,. .*,#/%/ *  . .,..                                                  
                                        ,,        ,/,  .*((* .,...   ,*.                                                 
                                      **(/,.,#   ..   *../.   ...  **%/                                                 
                                      ,#, #/  (   (      ,..    ../. .  .#/.                                             
                                    (/ *#.   ./  ..             .*..#, . ,,%,                                            
                                  * ,, (,   ,,  *#.      .    * / ,/   .  (.%,                                          
                                  / ,/    /  ,*  ,(,,     .    ,*, ,*,    ../*#                                          
                                ( ,**    ** ** , /       ,,. , *. .    .  .#(#                                          
                                #.,*(      .,(* //,.      .   * ( ,##*,%,   (#/(                                         
                              .(/#/.    .,**#*,,/,.     .,  .,.,  .. /%/ .  /#((.                                       
                                .//,         *. ,(,      ,,  ,*.,  ., ,##   . *#/,                                       
                                #/##        *.  ,(,      .,  ,, /  .. /*%*..   #%..                                      
                              #(,, ,*,. ...*///##(.**.. *      *. ,    *%*,    /%.                                      
                              ,//%(#,**(/(..   /,,,  .. /(/*./(*. .%(*  **%/     ((                                      
                        ,/(*#((#,*(*((((##%/%&&&%&%&%&#%*#(*,*.*(#(./#(#.%,.*,./#*.                                    
                      *%/(#.* ,*/%#(((/(//.** *,(*/,***.../* *//##%###.***//(,, /%*.                                    
                    /%(#(,*,*(/,//#/(/,.//((, /*/////*/*,**,*,/,(*(%//(#####/,*/(.//.  .                                
                    # #(*/(*.,,,..**.((/(,.,,,,, *,*/,,* ,,.,./* ,,,/%##,,.,**,,/(##%(/*.                                
              .,  */(%# ., ...,*,.../*,*(( ,,#,,/ .*//,,.,*.*,(/*,, .*/((%(,..,,,*,..,*(,####.                          
        ,(((,  (%#././ *,,..,*.*,**    ,/#/,*#/*/*,////,*/,,/ /*.,. ..,./**##%.*/.,. *,,. ./,.%                         
      /((.*,,*%.*, ,,***...,..., .,#%(,#(,%#*/#,,((#(%#(#%(/#*,. #/(**,,*. .,,/%#(*,.  ,.... **#/                       
      ( #%&/#,/  . /.#///,..,,*,,* #/&%/*,.%#(.#*#%/%/##%/%#/%/*%#/#*%&%/**# ..,*###((*  ./,..*.%.                      
    *%,%(,,.*,* . .# //  *(( *,( ,(*(.%&&(#%&#/,%/%#/#%/%/%#/*(*&% /%/.%##,....,,%/%,%#,*. ,*.#(                      
    (/&*&.  .  (,/(/##.../ ,/##%*&*&%/%&&&%* *&%&&%&%&&&%&&%(&%&(%/%,#(/%(%(,,. .,.(##%*,#  ..,/(.                     
    ,#(###((,.  ,./,,/..,*,%/ %&%&%&&&&%&%&%#/(#(#%&*%(((####%(***%/*%(%/##//%,,.,*.,**(#( %.   ,/*#*                    
    /%&#.%*/,. ...(/,*. */%,#*%&.,,,*%&&*%(/,%(   ,///(#%(%(%/*/./%/#/%/##/%#(/*.,*,.#%/%(,  ., */#/                   
    .(/% #   ., /%##/,* */(,*  ..&***.%(,&%(..**#,/,(,/..**(##%///,*./*#*,    /##(,*./,(((&(  ... .//*/                  
    .*(,%  (%###/(%#/*/*///(,  .*/.. *#.*&%(....(  ,/ ,(/(/##(###(#/,,%#/.   .#(%/*, .*,(%&%( .. .,,.*(/                 
    * #%&#*%(.##*(/,*(.%(#     .,. *#(*&%* ..*#..,(,.//#(./(%&%**(*,(,(     .#%/* ** *((&./* ,.,,*,.#/*.               
      ..#%.   ,, *(((/,(//,     , ,,,((.(%#. .(#.(,(*,*  **//%/(, #.##*/      /*%* .  */##/.//..  .. ,((/.              
            ,..  (.(/.//(*.  ,, , ,  /&,(%(*  *((. ,./*,./*./*(*/,. (%#       ,.#,    .*(.%  ,/..,   ,.*(*.             
              ..  *//. ,,%*//. , ,.,*. #%(&%/.  #  *..*/  **  (**.,(*/*# .       %#   ..*((#/  ./(    . .,(/  .          
              .. ..(,. *(%*   ,    ,/  *##%(/, ,(/,, /%(/(..* ./(,,,.#(*..       %*#.. .,,(*%   ..(,      */#  ,         
            *.   ./,..#(/.        #,   #%&##. .*. ***%/ (/...*///*,.((,..       (#** .. .//%    ,.**,     ,/#   ,       
            ,.  .,/.*/*./        .**    ((&%(..*    *(( ((*,.*,.,/  %(  ,        #.#..  .*/#,      */,,  .. ((          
          .. ..  ,,#.,*/,(        ...    .%&%(/*#.(/..,/ %(* .(# * ,*#,  ,         /#*# ./ *(#.   ...,,/  .  ,/((%#(,,.. 
          , ....,,*..,/ #        ..,.    *##*#.*   ,.,. ##* ..**%*,((  *,          /#,/*..,./#, .  .. .*,  ..    ,**/#/ 
        . ..  . .,*,,,/,(         .,,    .#/&%.*/   ,,.*%(     *(, %.(. /           /#*/ .  (%(.    .  ,** .  ..(/, *.  
      . ,  . .  .,(..,.*.         .*#    //.%#,#,,,* *,/#% . ..*/.(/    *            #*(   .,,#(..   . .,.,*(,*.  .     
      ,     ..  ../, *,/,        , ,,    *( /%#*./ ,  /*##/*(#/, (%/    ,.           */*( ..(./## .,.   ..  **.         
      .  .        .(, .*/           (,   ,( ((#,.,,(,   %//. ,...(/(#   *.           (#/,/.,,//((#,#*(*. .          .   
          .       ,.,( .**.          *((/,  *//%*. ***,  ///*.., *((*    .*            ,((*,/.*,,*/#,./(,*.              
                    (**/.(             /   (/,%(. . ,,  */,.(*  ,(% , /.                 .( .. ,,*.,%(,.(,              
                  / ./../(*           /    /**%#. , (   ,/* ,  . /%                           ... ,/,.#%*               
                  */ .*,  //*(           /, /((%#  .  ,  .(*,     (%                          .    ...(*  .##            
                  . ./(,*/./ **             /(*%#(  . *   #,.     /#,                      .***..*, ,*  ,*,              
                  /#  ,*. ( *.       ,#*   *#/%,/  . /  ((/      /(/       .                   *, ., ..    ,(.          
                  /#%   .*,,            ,,.  #/%,/. ,*/  (**     .(/*                              **  ((//##/           
                  / ,*.**%                  (/%#(. .* * (*,     .#(                                                     
                        *,#                  /(#&%* ., , ./,.    .#%                                                     
                                            ./%&%* .. . */,    .///                                                     
                                              #(&%. .. , **,    ,/#*                   .                                 
                                              ##*%. ./.. /*#   ///%                                                      
                                              .%/%* ,/,. /*(   //*#                    .                                 
                                              .#/%, ,(* .//,  #//#(                                                      
                                              %&%/ ,(* *,#  /%.(#*                                                      
                                              (&%/  (/,((# ,((,/%.                                                      
                                            *. ,&%,  /// #*  /#,#/     .                                                 
                                            ./#%&     /.(#    ,/*##/                                                     
                                          /../** /(*( / #%    ,,(#*                                                      
                                          .#%#///*.%. .*.#,    ,#%(,                                                    
                                      .* .%&%&##/%#&/  *(,((//..,#(#%    .                     *                        
                                            . *#%.    ,,*%(##&&/,                                               .     
                                                          ./#%.    (*/,                                                 
                                                                  ,/  .                                        
  ' 
    end
  end
end

