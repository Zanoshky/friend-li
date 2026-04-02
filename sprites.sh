#!/usr/bin/env bash
# sprites.sh - ASCII art sprites, species, eyes, hats, rarity system
# Sourced by the main `friend` script. Not executable on its own.

# --- Species ---
SPECIES=(duck goose blob cat dragon octopus owl penguin turtle snail ghost axolotl capybara cactus robot rabbit mushroom chonk)

# --- Eyes ---
EYES=('*' 'x' '@' 'o' '0' '^')

# --- Hats ---
HATS=(none crown tophat propeller halo wizard beanie tinyduck)

# --- Rarities ---
RARITIES=(common uncommon rare epic legendary)
RARITY_WEIGHTS=(60 25 10 4 1)

# --- Stat names ---
STAT_NAMES=(DEBUGGING PATIENCE CHAOS WISDOM SNARK)

# --- Rarity floors ---
declare -A RARITY_FLOOR
RARITY_FLOOR[common]=5
RARITY_FLOOR[uncommon]=15
RARITY_FLOOR[rare]=25
RARITY_FLOOR[epic]=35
RARITY_FLOOR[legendary]=50

# --- Rarity stars ---
declare -A RARITY_STARS
RARITY_STARS[common]="*"
RARITY_STARS[uncommon]="**"
RARITY_STARS[rare]="***"
RARITY_STARS[epic]="****"
RARITY_STARS[legendary]="*****"

# --- Rarity colors ---
declare -A RARITY_COLOR_CODE
RARITY_COLOR_CODE[common]="\033[0;37m"      # white/gray
RARITY_COLOR_CODE[uncommon]="\033[0;32m"     # green
RARITY_COLOR_CODE[rare]="\033[0;34m"         # blue
RARITY_COLOR_CODE[epic]="\033[0;35m"         # magenta
RARITY_COLOR_CODE[legendary]="\033[1;33m"    # bold yellow

# --- Hearts for petting animation ---
HEART="<3"
PET_FRAMES=(
  "   ${HEART}    ${HEART}   "
  "  ${HEART}  ${HEART}   ${HEART}  "
  " ${HEART}   ${HEART}  ${HEART}   "
  "${HEART}  ${HEART}      ${HEART} "
  ".    .   .  "
)

# --- Hat lines (12 chars wide) ---
hat_line() {
  case "$1" in
    crown)    echo '   \^^^/    ' ;;
    tophat)   echo '   [___]    ' ;;
    propeller) echo '    -+-     ' ;;
    halo)     echo '   (   )    ' ;;
    wizard)   echo '    /^\     ' ;;
    beanie)   echo '   (___)    ' ;;
    tinyduck) echo '    ,>      ' ;;
    *)        echo '            ' ;;
  esac
}

# --- Sprite bodies (5 lines each, 3 frames per species) ---
# {E} is replaced with the eye character at render time.
# Each function prints 5 lines for the given frame (0, 1, or 2).

sprite_body() {
  local species="$1"
  local frame="$2"
  local E="$3"

  case "${species}" in
    duck)
      case $frame in
        0) cat <<EOF
            
    __      
  <(${E} )___  
   (  ._>   
    \`--'    
EOF
;;
        1) cat <<EOF
            
    __      
  <(${E} )___  
   (  ._>   
    \`--'~   
EOF
;;
        *) cat <<EOF
            
    __      
  <(${E} )___  
   (  .__>  
    \`--'    
EOF
;;
      esac ;;
    goose)
      case $frame in
        0) cat <<EOF
            
     (${E}>    
     ||     
   _(__)_   
    ^^^^    
EOF
;;
        1) cat <<EOF
            
    (${E}>     
     ||     
   _(__)_   
    ^^^^    
EOF
;;
        *) cat <<EOF
            
     (${E}>>   
     ||     
   _(__)_   
    ^^^^    
EOF
;;
      esac ;;
    blob)
      case $frame in
        0) cat <<EOF
            
   .----.   
  ( ${E}  ${E} )  
  (      )  
   \`----'   
EOF
;;
        1) cat <<EOF
            
  .------.  
 (  ${E}  ${E}  ) 
 (        ) 
  \`------'  
EOF
;;
        *) cat <<EOF
            
    .--.    
   (${E}  ${E})   
   (    )   
    \`--'    
EOF
;;
      esac ;;
    cat)
      case $frame in
        0) cat <<EOF
            
   /\_/\    
  ( ${E}   ${E})  
  (  w  )   
  (")_(")   
EOF
;;
        1) cat <<EOF
            
   /\_/\    
  ( ${E}   ${E})  
  (  w  )   
  (")_(")~  
EOF
;;
        *) cat <<EOF
            
   /\-/\    
  ( ${E}   ${E})  
  (  w  )   
  (")_(")   
EOF
;;
      esac ;;
    dragon)
      case $frame in
        0) cat <<EOF
            
  /^\  /^\  
 <  ${E}  ${E}  > 
 (   ~~   ) 
  \`-vvvv-'  
EOF
;;
        1) cat <<EOF
            
  /^\  /^\  
 <  ${E}  ${E}  > 
 (        ) 
  \`-vvvv-'  
EOF
;;
        *) cat <<EOF
   ~    ~   
  /^\  /^\  
 <  ${E}  ${E}  > 
 (   ~~   ) 
  \`-vvvv-'  
EOF
;;
      esac ;;
    octopus)
      case $frame in
        0) cat <<EOF
            
   .----.   
  ( ${E}  ${E} )  
  (______)  
  /\/\/\/\  
EOF
;;
        1) cat <<EOF
            
   .----.   
  ( ${E}  ${E} )  
  (______)  
  \/\/\/\/  
EOF
;;
        *) cat <<EOF
     o      
   .----.   
  ( ${E}  ${E} )  
  (______)  
  /\/\/\/\  
EOF
;;
      esac ;;
    owl)
      case $frame in
        0) cat <<EOF
            
   /\  /\   
  ((${E})(${E}))  
  (  ><  )  
   \`----'   
EOF
;;
        1) cat <<EOF
            
   /\  /\   
  ((${E})(${E}))  
  (  ><  )  
   .----.   
EOF
;;
        *) cat <<EOF
            
   /\  /\   
  ((${E})(-))  
  (  ><  )  
   \`----'   
EOF
;;
      esac ;;
    penguin)
      case $frame in
        0) cat <<EOF
            
  .---.     
  (${E}>${E})     
 /(   )\    
  \`---'     
EOF
;;
        1) cat <<EOF
            
  .---.     
  (${E}>${E})     
 |(   )|    
  \`---'     
EOF
;;
        *) cat <<EOF
  .---.     
  (${E}>${E})     
 /(   )\    
  \`---'     
   ~ ~      
EOF
;;
      esac ;;
    turtle)
      case $frame in
        0) cat <<EOF
            
   _,--._   
  ( ${E}  ${E} )  
 /[______]\ 
  \`\`    \`\`  
EOF
;;
        1) cat <<EOF
            
   _,--._   
  ( ${E}  ${E} )  
 /[______]\ 
   \`\`  \`\`   
EOF
;;
        *) cat <<EOF
            
   _,--._   
  ( ${E}  ${E} )  
 /[======]\ 
  \`\`    \`\`  
EOF
;;
      esac ;;
    snail)
      case $frame in
        0) cat <<EOF
            
 ${E}    .--.  
  \  ( @ )  
   \_\`--'   
  ~~~~~~~   
EOF
;;
        1) cat <<EOF
            
  ${E}   .--.  
  |  ( @ )  
   \_\`--'   
  ~~~~~~~   
EOF
;;
        *) cat <<EOF
            
 ${E}    .--.  
  \  ( @  ) 
   \_\`--'   
   ~~~~~~   
EOF
;;
      esac ;;
    ghost)
      case $frame in
        0) cat <<EOF
            
   .----.   
  / ${E}  ${E} \  
  |      |  
  ~\`~\`\`~\`~  
EOF
;;
        1) cat <<EOF
            
   .----.   
  / ${E}  ${E} \  
  |      |  
  \`~\`~~\`~\`  
EOF
;;
        *) cat <<EOF
    ~  ~    
   .----.   
  / ${E}  ${E} \  
  |      |  
  ~~\`~~\`~~  
EOF
;;
      esac ;;
    axolotl)
      case $frame in
        0) cat <<EOF
            
}~(______)~{
}~(${E} .. ${E})~{
  ( .--. )  
  (_/  \_)  
EOF
;;
        1) cat <<EOF
            
~}(______){~
~}(${E} .. ${E}){~
  ( .--. )  
  (_/  \_)  
EOF
;;
        *) cat <<EOF
            
}~(______)~{
}~(${E} .. ${E})~{
  (  --  )  
  ~_/  \_~  
EOF
;;
      esac ;;
    capybara)
      case $frame in
        0) cat <<EOF
            
  n______n  
 ( ${E}    ${E} ) 
 (   oo   ) 
  \`------'  
EOF
;;
        1) cat <<EOF
            
  n______n  
 ( ${E}    ${E} ) 
 (   Oo   ) 
  \`------'  
EOF
;;
        *) cat <<EOF
    ~  ~    
  u______n  
 ( ${E}    ${E} ) 
 (   oo   ) 
  \`------'  
EOF
;;
      esac ;;
    cactus)
      case $frame in
        0) cat <<EOF
            
 n  ____  n 
 | |${E}  ${E}| | 
 |_|    |_| 
   |    |   
EOF
;;
        1) cat <<EOF
            
    ____    
 n |${E}  ${E}| n 
 |_|    |_| 
   |    |   
EOF
;;
        *) cat <<EOF
 n        n 
 |  ____  | 
 | |${E}  ${E}| | 
 |_|    |_| 
   |    |   
EOF
;;
      esac ;;
    robot)
      case $frame in
        0) cat <<EOF
            
   .[||].   
  [ ${E}  ${E} ]  
  [ ==== ]  
  \`------'  
EOF
;;
        1) cat <<EOF
            
   .[||].   
  [ ${E}  ${E} ]  
  [ -==- ]  
  \`------'  
EOF
;;
        *) cat <<EOF
     *      
   .[||].   
  [ ${E}  ${E} ]  
  [ ==== ]  
  \`------'  
EOF
;;
      esac ;;
    rabbit)
      case $frame in
        0) cat <<EOF
            
   (\__/)   
  ( ${E}  ${E} )  
 =(  ..  )= 
  (")__(")  
EOF
;;
        1) cat <<EOF
            
   (|__/)   
  ( ${E}  ${E} )  
 =(  ..  )= 
  (")__(")  
EOF
;;
        *) cat <<EOF
            
   (\__/)   
  ( ${E}  ${E} )  
 =( .  . )= 
  (")__(")  
EOF
;;
      esac ;;
    mushroom)
      case $frame in
        0) cat <<EOF
            
 .-o-OO-o-. 
(__________)
   |${E}  ${E}|   
   |____|   
EOF
;;
        1) cat <<EOF
            
 .-O-oo-O-. 
(__________)
   |${E}  ${E}|   
   |____|   
EOF
;;
        *) cat <<EOF
   . o  .   
 .-o-OO-o-. 
(__________)
   |${E}  ${E}|   
   |____|   
EOF
;;
      esac ;;
    chonk)
      case $frame in
        0) cat <<EOF
            
  /\    /\  
 ( ${E}    ${E} ) 
 (   ..   ) 
  \`------'  
EOF
;;
        1) cat <<EOF
            
  /\    /|  
 ( ${E}    ${E} ) 
 (   ..   ) 
  \`------'  
EOF
;;
        *) cat <<EOF
            
  /\    /\  
 ( ${E}    ${E} ) 
 (   ..   ) 
  \`------'~ 
EOF
;;
      esac ;;
  esac
}

# Render a face (one-liner) for narrow display
render_face() {
  local species="$1"
  local eye="$2"
  case "${species}" in
    duck)     echo "(${eye}>" ;;
    goose)    echo "(${eye}>" ;;
    blob)     echo "(${eye}${eye})" ;;
    cat)      echo "=${eye}w${eye}=" ;;
    dragon)   echo "<${eye}~${eye}>" ;;
    octopus)  echo "~(${eye}${eye})~" ;;
    owl)      echo "(${eye})(${eye})" ;;
    penguin)  echo "(${eye}>)" ;;
    turtle)   echo "[${eye}_${eye}]" ;;
    snail)    echo "${eye}(@)" ;;
    ghost)    echo "/${eye}${eye}\\" ;;
    axolotl)  echo "}${eye}.${eye}{" ;;
    capybara) echo "(${eye}oo${eye})" ;;
    cactus)   echo "|${eye}  ${eye}|" ;;
    robot)    echo "[${eye}${eye}]" ;;
    rabbit)   echo "(${eye}..${eye})" ;;
    mushroom) echo "|${eye}  ${eye}|" ;;
    chonk)    echo "(${eye}.${eye})" ;;
  esac
}

# Render full sprite with hat
render_sprite() {
  local species="$1"
  local eye="$2"
  local hat="$3"
  local frame="${4:-0}"

  local body
  body=$(sprite_body "${species}" "${frame}" "${eye}")

  # Replace hat line (first line) if hat is not none and first line is blank
  if [[ "${hat}" != "none" ]]; then
    local first_line
    first_line=$(echo "${body}" | head -1)
    local trimmed="${first_line// /}"
    if [[ -z "${trimmed}" ]]; then
      local hat_l
      hat_l=$(hat_line "${hat}")
      body="${hat_l}
$(echo "${body}" | tail -n +2)"
    fi
  fi

  echo "${body}"
}
