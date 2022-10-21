#!/bin/bash

#search for version of arducopter
#!/bin/bash
filename='ArduCopter/version.h'
n=1
while read line; do
# reading each line
substr="THISFIRMWARE"
if [[ $line == *"$substr"* ]];
then
    #extract version name
	Firmware=$(sed -E 's/.*"([^:]+)".*/\1/' <<< "$line")
	Firmware_Ver="${Firmware#*V}_"
	echo " "
	echo "Found ArduCopter Version of this branch : $Firmware_Ver"
	echo " "
fi
done < $filename


#ask what firmware compile -outdoor -indoor -all

echo "Firmware to Compile"
echo " "
echo "1 - LuminousBee5(outdoor)"
echo " "
echo "2 - LuminousBeeMini(indoor)"
echo " "
read -p "Choose: " menu_choose
echo " "

if [ $menu_choose =  1 ]
then
	echo "Do you want to upload the firmware at the end of the compile 📝➡️🚁 ?"
	echo " "
	read -p "y or n " upload_choose
	if [ $upload_choose = 'y' ]
	then
			echo "Start Compile and Upload LuminousBee5 🐝🐝🐝 "
			echo " "
			sleep 3
			#run command and check it
			if ./waf distclean && ./waf configure --board luminousbee5 && ./waf copter &&  python3 Tools/scripts/uploader.py build/luminousbee5/bin/arducopter.apj;
			then

				echo "Outdoor Firmware : Compile Successful and Upload ✅ "
				#rename firmware file 

					board="luminousbee5_"
					date_of_compile="$(date '+%Y-%m-%d').apj"
					name="$board$Firmware_Ver$date_of_compile"
					echo "Renaming Firmware file ... to $name "
					mv "build/luminousbee5/bin/arducopter.apj" "$name"
					echo " "
					echo "File renamed !"


			else
				echo "Outdoor Firmware : Something went Wrong ❌"

			fi
	elif [ $upload_choose = 'n' ]
	then
			echo "Start Compile LuminousBee5 🐝🐝🐝 "
			echo " "
			sleep 3
			#run command and check it
			if ./waf distclean && ./waf configure --board luminousbee5 && ./waf copter;
			then
				echo "Outdoor Firmware : Compile Successful ✅!"
				#rename firmware file 
				
				board="luminousbee5_"
				date_of_compile="$(date '+%Y-%m-%d').apj"
				name="$board$Firmware_Ver$date_of_compile"
				echo "Renaming Firmware file ... to $name "
				mv "build/luminousbee5/bin/arducopter.apj" "build/luminousbee5/bin/$name"
				echo " "
				echo "File renamed !"

			else
				echo " "
				echo "Outdoor Firmware : Something went Wrong ❌!s"

			fi

	fi




elif [ $menu_choose = 2 ]
then
	echo "Do you want to upload the firmware at the end of the compile 📝➡️🚁 ?"
	read -p "y or n " upload_choose
	if [ $upload_choose = 'y' ]
	then
			echo "Start Compile and Upload LuminousBeeMini-2 🐝🐝🐝 "
			echo " "
			sleep 3
			#run command and check it
			if ./waf distclean && ./waf configure --board luminousbee-mini2 && ./waf copter &&  python3 Tools/scripts/uploader.py build/luminousbee-mini2/bin/arducopter.apj;
			then
				echo "Indoor Firmware : Compile Successful and Upload ✅ "
				board="luminousbee-mini_"
				date_of_compile="$(date '+%Y-%m-%d').apj"
				name="$board$Firmware_Ver$date_of_compile"
				echo "Renaming Firmware file ... to $name "
				mv "build/luminousbee-mini2/bin/arducopter.apj" "build/luminousbee-mini2/bin/$name"
				echo "File Renamed"
			else
				echo "Indoor Firmware : Something went Wrong ❌"

			fi
	elif [ $upload_choose = 'n' ]
	then
			echo "Start Compile LuminousBee-Mini2 🐝🐝🐝 "
			echo " "
			sleep 3
			#run command and check it
			if ./waf distclean && ./waf configure --board luminousbee-mini2 && ./waf copter;
			then
				echo "Indoor Firmware : Compile Successful ✅ ! "
				board="luminousbee-mini_"
				date_of_compile="$(date '+%Y-%m-%d').apj"
				name="$board$Firmware_Ver$date_of_compile"
				echo "Renaming Firmware file ... to $name "
				mv "build/luminousbee-mini2/bin/arducopter.apj" "build/luminousbee-mini2/bin/$name"
				echo "File renamed ! "
			else
				echo "Indoor Firmware : Something went Wrong ❌ !"

			fi

	fi

fi #last if
