###########################################################################
#	Author: Ahmad Afkandeh (Arta Aria)
#	A simple code to use dislocker program to mounting and unmounting
#	   any bitlocked encrypted disk. 
#	This code wroted cause of two problems I had:
#	   1- when you use dislocker at command line you should pass the password of drive
#	      into bash and it would stays in the history of bash, so every time I had to 
#	      clear the bash history to remove it.
#	   2- I have some drives which encrypted with bitlocker and I needed those sometimes simultaneously
#	       so I wrote this to do the mounting and unmounting automatically and make the job easier.
#	the usage is simple, after installing dislocker project "https://github.com/Aorimn/dislocker",
#	just type: ./bitmount.sh.
#	there are two options ("-m & -u), for mounting and unmounting the drive.
#	for mounting: ./bitmount.sh -m sdaX  	   'sdaX is the name of the drive
#	and for unmounting: ./bitmount.sh -m sdaX  'sdaX is the name of the drive
#	feel free to change as you wish.
###########################################################################
if [ $# -gt 2 ] || [ $# -lt 2 ] || ([ $1 != '-m' ] && [ $1 != '-u' ]); then
	echo "Invalid input, Valid inputs:"
	echo "	-m	Mount sdaX"
	echo "	-u	Unmount sdaX"
	echo "	ex: bitmount.sh -m sda1"
	exit
elif [ $1 == '-m' ]; then
	if [ ! -e '/dev/'$2 ]; then
		echo "Invalid Address, check Address and try again."
		exit
	fi
	echo "dislockeer example:"
	echo "dislocker -V sdX -uPASSWORD -- /media/dislocked"
	echo "sudo mount -o loop,rw /media/dislocked/dislocker-file /media/unlockeddisk"
	echo "the disk address:/dev/"$2
	Addr=$2

	echo -n "Enter the Password:"
	read -s Pass
	echo 

	DISLOCKED_DRIVE_ADDRESS="/media/dislocked"$Addr
	DISLOCKER_FILES_ADDRESS="/media/bitlocker_decrypted"$Addr
	if [ ! -d $DISLOCKED_DRIVE_ADDRESS ]; then
		echo "creating folder for dislocked drive"
		mkdir $DISLOCKED_DRIVE_ADDRESS
	fi

	if [ ! -d $DISLOCKER_FILES_ADDRESS ]; then
		echo "creating folder for decryped data"
		mkdir $DISLOCKER_FILES_ADDRESS
	fi

	if mount | grep $DISLOCKER_FILES_ADDRESS > /dev/null; then
		echo "Oops! There is already something mounted on this location, Unmount it first and then try again."
		exit 
	fi
	if mount | grep $DISLOCKED_DRIVE_ADDRESS > /dev/null; then
		echo "Oops! There is already something mounted on this location, Unmount it first and then try again."
		exit 
	fi

	echo "Decrypting bitlocked drive to:" $DISLOCKED_DRIVE_ADDRESS
	dislocker -V "/dev/"$Addr -u$Pass -- $DISLOCKED_DRIVE_ADDRESS

	echo "Mounting Decrypted data to:" $DISLOCKER_FILES_ADDRESS
	mount -o loop,rw $DISLOCKED_DRIVE_ADDRESS/dislocker-file $DISLOCKER_FILES_ADDRESS

	echo "Enjoy!"
elif [ $1 == '-u' ];then
	if [ ! -e '/dev/'$2 ]; then
		echo "Invalid Address, check Address and try again."
		exit
	fi
	Addr=$2
	DISLOCKED_DRIVE_ADDRESS="/media/dislocked"$Addr
	DISLOCKER_FILES_ADDRESS="/media/bitlocker_decrypted"$Addr
	if [ -d $DISLOCKER_FILES_ADDRESS ]; then
		echo "unmounting folder of decryped data"
		umount $DISLOCKER_FILES_ADDRESS 
		rmdir $DISLOCKER_FILES_ADDRESS
	fi
sleep 2
	if [ -d $DISLOCKED_DRIVE_ADDRESS ]; then
		echo "unmounting folder of dislocked drive"
		umount $DISLOCKED_DRIVE_ADDRESS
		rmdir $DISLOCKED_DRIVE_ADDRESS
	fi
echo "done"
fi
exit

