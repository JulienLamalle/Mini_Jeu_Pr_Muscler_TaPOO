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


adversaries = Array.new

playerhuman = HumanPlayer.new(name_of_human_player)
player1 = Player.new("Josiane")
adversaries << player1
player2 = Player.new("José")
adversaries << player2

while playerhuman.life_points > 0 && (player1.life_points > 0 || player2.life_points > 0) 
  puts "Voici l'état de santé de notre champion #{name_of_human_player}"
  puts playerhuman.show_state
  puts "Quelle action veux_tu effectuer ?"
  puts "a - chercher une meilleure arme"
  puts "s - chercher à se soigner "
  puts ""
  
  #the following loop are here to prevent from the case where a bot is already dead and the user would like to attack him
  if player1.life_points > 0 
    print "Tape 0 pour attaquer #{player1.name} "
    print "#{player1.show_state}"
    else
    puts "#{player1.name} est mort, tu ne peux plus l'attaquer"
  end
  if player2.life_points > 0 
    print "Tape 1 pour attaquer #{player2.name} "
    print "#{player2.show_state}"
    else
    puts "#{player2.name} est mort, tu ne peux plus l'attaquer"
  end
  
  user_choice = gets.chomp.to_s

  if user_choice == "a"
    playerhuman.search_weapon
  elsif user_choice == "s"
    playerhuman.search_health_pack
  elsif user_choice == "0"
    playerhuman.attacks(player1)
  elsif user_choice == "1"
    playerhuman.attacks(player2)
  else "Tu n'as pas saisie de commande correct ! Tu passes ton tour"
  end

  puts " "
  if player1.life_points > 0 || player2.life_points > 0 
    puts "--------------! Les ennemies contre-attaquent !--------------"
    puts ""
    adversaries.each do |bot|
      if bot.life_points > 0
      bot.attacks(playerhuman)
    end
  end
  end
end 

puts "La partie est finie"
if playerhuman.life_points != 0
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

  else "LOOOOOOSER! Tu as perdu"
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
