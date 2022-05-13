# FH to IT Map Objects - File Cleaner
Readies a CFG file with object coordinates generated with FeralHeart for Impressive Title using FeralHeart coordinates for map objects.

## How it works
I've made a little script, which will turn FH-generated Objects.cfg files from this:

`[MyTrees2/firTree.mesh]

515.408 61.5376 3517.06;1.885 1.96 1.897

1099.7 68.2354 3780.78;1.885 2.40801 1.897`


 to this:
 
`[firTree.mesh]

515.408 61.5376 3517.06;1.885 1.96 1.897

1099.7 68.2354 3780.78;1.885 2.40801 1.897`

## Requirements
o Basic setup of an Impressive Title server
	o Link: https://kito.forumotion.t532-download-and-instructions-compile-your-own-it
	
o Your game needs to be able to read FeralHeart coordinates for map objects
	o Link to guide: https://cdn.discordapp.com/attachments/948478699362205736/948482084987613195/ENG_FH_mapmaker.pdf
  
  
## Other:
Included in this package is the FH to IT map converter by JBRWolf on kito.forumotion.com
We need this converter for all collisions, since they cannot be read by the game

Instructions: https://kito.forumotion.t3356-fh-to-it-map-converter-version-0-6?highlight=converter


## GETTING STARTED:
o Drop your SomeMapObjects.cfg files into this directory.

o Do a right click on FH_to_IT_MapObjects_Cleaner.ps1 and choose "Open with Powershell"

o It will now convert all your files. 

o Check them for collisions and if there are some, convert them using the FH to IT Map Converter by JBRWolf

o Copy your cleaned SomeMapObjects.cfg files back into your map folder on your server
