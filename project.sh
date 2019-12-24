#this function splits the input character
splite(){
a=$2
punct="$3"
column=` cat $1 | awk 'NR=='$a'{print NF}' `
for((b=1 ; b<column+1 ; b++))
do 

  val=`cat $1|awk NR==$a{print' $'$b}`	
  replace=
		check=`cat $1|awk NR==$a{print' $'$b}|grep "$punct"`
                isDot=`cat $1|awk NR==$a{print' $'$b}|grep "^[\.]$"`
		if [ -n "$check" ]
			then	
                        if [ -z "$isDot" ]
			then
			number=`cat $1|awk NR==$a{print' $'$b}|awk -F"$punct" '{print NF }'`
			replace=
			for((c=1;c<number;c++))
			do
				replace+=`cat $1|awk NR==$a{print' $'$b}|awk -F"$punct" {print' $'$c}`
				replace+=$4
			done
			replace+=`cat $1|awk NR==$a{print' $'$b}|awk -F"$punct" {print' $'$c}`

			sed -i "s/$val/$replace/1" "$1"
			#`echo "$replace" | sed "s/$1/&-/1"`
			echo "replace is  $b  $replace"

   		        fi
		fi
		
	
    column=` cat $1 | awk 'NR=='$a'{print NF}' `
done
}
if [ ! -f "$1" ]
then
echo "$1 doesn't exist"
else
if [ ! -r "$1" ]
then
echo "$1 is not readable"
else
if [ ! -w "$1" ]
then
echo "$1 is not writable"
else
#check if the file exists, readable and writable
row=` cat $1 | awk 'END{print NR }' `
#number of raws
#22
counter=0
declare -a list
for((a=1;a<row+1;a++))
do 
splite $1 $a "," ", "
splite $1 $a '\.' '\. '
splite $1 $a "\?" "? "
splite $1 $a "\:" ": "
splite $1 $a "\;" "; "
splite $1 $a "\'" "' "
splite $1 $a "!'" "! "
#call the function for different punctutaion marks
replace=


value=	
column=` cat $1 | awk 'NR=='$a'{print NF}' `
#number of columds

for((d=1;d<column+1;d++))
do
  next=$(($d+1))
  prev=$(($d-1))
  #next and previous indexes
  echo "next is $next"
  isNextPunc=`cat $1|awk NR==$a{print' $'$next}| grep "^[\.\?\:\;\'\!,]*$"`
  #is next character a punctuation mark
  if [ -n "$isNextPunc" ]
  then
  value+=`cat $1|awk NR==$a{print' $'$d}`
  #put the value without space
  else
  str=`cat $1|awk NR==$a{print' $'$d}`
  #value
  endPoint=`cat $1|awk NR==$a{print' $'$prev}| grep "[\.\?\:]$"`
  #is end with some punctuation mark
  apostrophe=`cat $1|awk NR==$a{print' $'$d}| grep "[\']$"`
  #is apostrophe
  isInt=`cat $1|awk NR==$a{print' $'$d}| grep "^[0-9]\+[\.]$"`
  #is number an integer and end with a dot
  isNextInt=`cat $1|awk NR==$a{print' $'$next}| grep "^[0-9]\+"`
  #is next word a integer
  isPrevInt=`cat $1|awk NR==$a{print' $'$prev}| grep "^[0-9]\+"`
  #is previous word a integer
  isPunct=`cat $1|awk NR==$a{print' $'$d}| grep "^[\.]$"`
  
  if [ -n "$isInt" ] && [ -n "$isNextInt" ]
  then
  echo ""
  elif [ -n "$isNextInt" ] && [ -n "$isPunct" ] && [ -n "$isPrevInt" ]
  then
  echo ""
  #if there is an integer before and after a word, then put no space after word
  elif [ -n "$endPoint" ] 
  then
  str="$(tr '[:lower:]' '[:upper:]' <<< ${str:0:1})${str:1}"
  str+=" "
  #if it's necessary make the first character of the letter capital, put a space
  elif [ -z "$apostrophe" ]
  then
  str+=" "
  #if it's not apostrophe put a space
  fi
  value+="$str"
  fi


done
list[$counter]=$value
#add line to array
let "counter++"
done

for((a=0; a < counter; a++))
	do
	num=$(($a+1))
	line=`cat $1 |head -"$num" | tail -1`
	sed -i "s/$line/${list[a]}/g" "$1"
	#swap updated line and old line
done
fi
fi
fi
echo ${list[@]}

