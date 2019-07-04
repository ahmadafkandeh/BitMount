
A simple code to use dislocker program to mounting and unmounting any bitlocked encrypted disk. 

This code wroted cause of two problems I had:

   1- when you use dislocker at command line you should pass the password of drive
      into bash and it would stays in the history of bash, so every time I had to 
      clear the bash history to remove it.

   2- I have some drives which encrypted with bitlocker and I needed those sometimes simultaneously
       so I wrote this to do the mounting and unmounting automatically and make the job easier.

the usage is simple, after installing dislocker project " https://github.com/Aorimn/dislocker " ,just type: ./bitmount.sh

there are two options ("-m & -u), for mounting and unmounting the drive.

for mounting: ./bitmount.sh -m sdaX  	   'sdaX is the name of the drive

and for unmounting: ./bitmount.sh -m sdaX  'sdaX is the name of the drive

feel free to change as you wish.
