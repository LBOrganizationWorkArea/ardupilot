#!/bin/bash


#ask what firmware compile -outdoor -indoor -all

echo "Firmware to Compile"

echo "1 - LuminousBee5(outdoor)"

echo "2 - LuminousBeeMini(indoor)"

read -p "Choose: " menu_choose

echo $menu_choose

if [ $menu_choose =  1 ]
then
	echo "Start Compile LuminousBee5 🐝🐝🐝 "
	sleep 3
	#run command and check it
	if ./waf distclean && ./waf configure --board luminousbee5 && ./waf copter;
	then
		echo "Outdoor Firmware : Compile Successful ✅ "
	else
		echo "Outdoor Firmware : Something went Wrong ❌"

	fi



elif [ $menu_choose = 2 ]
then
	 echo "Start Compile LuminousBee-Mini 🐝🐝🐝 "
        sleep 3
        #run command and check it
        if ./waf distclean && ./waf configure --board luminousbee-mini2 && ./waf copter;
        then
                echo " Indoor Firmware : Compile Successful ✅ "
        else
                echo "Indoor Firmware : Something went Wrong ❌"

        fi

fi #last if
