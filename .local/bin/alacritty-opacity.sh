#! /bin/sh

alacrittyrc_path=~/.config/alacritty/alacritty.yml

#sed -i "s/background_opacity.*/background_opacity: 0.$1/" $alacrittyrc_path
#Check arg's an integer

#if [ ${#1} -eq 2 ]
#then
#  echo "It's two characters long"
#fi


#Check that argument is a number
if     [ -z "${1##*[!0-9]*}" ]
  then   
	echo "Numbers 0-100 only."
	exit 0
fi


#[ ${#1} -eq 1 ] && echo YES ; sed -i "s/background_opacity.*/background_opacity: 0.0$1/" $alacrittyrc_path


if [ ${#1} -eq 1 ]
    then
        sed -i "s/opacity:.*/opacity: 0.0$1/" $alacrittyrc_path
elif [ ${#1} -eq 2 ]
    then
       sed -i "s/opacity:.*/opacity: 0.$1/" $alacrittyrc_path
elif [ ${#1} -eq 3 ]
    then
       sed -i "s/opacity:.*/opacity: 1.0/" $alacrittyrc_path
fi
