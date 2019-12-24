if [ ! -e "$1" ]
then
echo "$1 doesn't exist"
else
counter=0
counter1=0
#indexes for array
declare -a array1=(`ls "$1"`);
#put all files under the input file in the array
declare -a array=
length1=`ls "$1" | wc -l`
for((a=0;a<length1;a++))
 do
  x=${array1[a]}
  if [ -f "$1/${array1[a]}" ]
  then
    if [ "$1$counter1" != "${array1[a]}" ]
     then
     `mv "$1/${array1[a]}" "$1/$1$counter1" `
     let "counter1++"
     #if it's a regular file and not have the same name, change its name
     fi
  else
  array[$counter]=$x
  #if it's not add it to array
  let "counter++"
  fi
done
echo "Do you want to also update the directories under $1[y/n]"
read check
if [ "$check" = "y" ]
then
counter3=0
for((a=0;a<counter;a++))
do
x=${array[a]}
declare -a arr=(`ls "$1/$x"`);
echo "Do you want to change name of the file[y/n]"
read check1
if [ "$check1" = "y" ]
then
echo "the old name was $x enter the new name"
read name
     `mv "$1/$x" "$1/$name" `
      x=$name
      #if usert wants to change the name of the file
      #change the name with the input value
fi
length1=`ls "$1/$x" | wc -l`
 if [ $length1 = 0 ]
 then
   echo "empty"
 else
  for((b=0;b<length1;b++))
  do 
     if [ -f "$1/$x/${arr[b]}" ]
    then
    if [ "$x$counter3" != "${arr[b]}" ]
     then
    `mv "$1/$x/${arr[b]}" "$1/$x/$x$counter3"  `
     #if it's a regular file and not have the same name, change its name
     let "counter3++"     
     fi
     fi
  done
 fi
done
fi
fi
