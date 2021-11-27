#!/bin/bash

wiersze=3

kolumny=3

tura=1

declare -A plansza

imiona_graczy() {

echo -n "Imie pierwszego gracza: "
                read GraczA
echo -n "Imie drugiego gracza: "
                read GraczB

}

losuj_gracza() {

losowanie[0]="$GraczA"
losowanie[1]="$GraczB"

size=${#losowanie[@]}
index=$(($RANDOM % $size))

}

wypelnij_plansze() {

for ((x=0; x<wiersze; x++ )) do
   for (( y=0; y<kolumny; y++ )) do
      plansza[$x,$y]=-1
   done
done

}

wyswietl_plansze(){

   for ((x=0; x<wiersze; x++ )) do
       echo
       for (( y=0; y<kolumny; y++ )) do
	   if [ "${plansza[$x,$y]}" = "1" ]; then
		   printf "%3s" "X"
	   elif [ "${plansza[$i,$j]}" = "0" ]; then
		   printf "%3s" "O"
           else
           	   printf "%3s" "${plansza[$x,$y]}"
           fi
       done
   done
   echo

}

czy_remis(){

  remis=1

   for ((x=0; x<wiersze; x++ )) do
      for (( y=0; y<kolumny; y++ )) do
         if [ ${plansza[$x,$y]} == -1 ]; then
             remis=0
         fi
      done
   done

   if [ $remis == "1" ]; then
       echo "Remis"
       ((tura=tura+1))
       echo "Koniec gry, zaczynamy ture $tura"
       gra
   fi

}

sprawdz_wynik(){

   wygrana=0

   for((x=0; x<wiersze; x++)){
        if [[ ${plansza[$x,0]} != -1 && ${plansza[$x,0]} == ${plansza[$x,1]} && ${plansza[$x,0]} == ${plansza[$x,2]} ]]; then
                wygrana=1
        fi
   }

   for((y=0; y<kolumny; y++)){
        if [[ ${plansza[0,$y]} != -1 && ${plansza[0,$y]} == ${plansza[1,$y]} && ${plansza[0,$y]} == ${plansza[2,$y]} ]]; then
                wygrana=1
        fi
   }

   if [[ ${plansza[0,0]} != -1 && ${plansza[0,0]} == ${plansza[1,1]} && ${plansza[0,0]} == ${plansza[2,2]} ]]; then
        wygrana=1
   fi

   if [[ ${plansza[0,2]} != -1 && ${plansza[0,2]} == ${plansza[1,1]} && ${plansza[0,2]} == ${plansza[2,0]} ]]; then
        wygrana=1
   fi

   if [ "$wygrana" == "1" ]; then
	((tura=tura+1))
        echo "Wygrana. Zaczynamy ture $tura"
        gra
   fi

 czy_remis


}

gra() {

echo
losuj_gracza
wypelnij_plansze

echo "Zaczyna ${losowanie[$index]} "
echo

while true
do
    	while true
    	do

		echo -n "${losowanie[$index]} - wybierz wiersz (0-2) i kolumne (0-2) dla kolek: "
		read x y
        	if [ ${plansza[$x,$y]} == -1 ]; then 
	    	plansza[$x,$y]=0 
           	break 
        	fi
        	echo "Wybrana pozycja jest zajeta."

    	done

  	wyswietl_plansze
  	
	echo
	
	sprawdz_wynik

    	while true
    	do

    		echo -n "${losowanie[$index-1]} - wybierz wiersz (0-2) i kolumne (0-2) dla krzyzykow: "
    		read x y
    		if [ ${plansza[$x,$y]} == -1 ]; then
            	plansza[$x,$y]=1
            	break
    		fi
    		echo "Wybrana pozystacja  juz zajeta."

    	done

  	wyswietl_plansze
  	echo
  	sprawdz_wynik

done

}

imiona_graczy

gra


