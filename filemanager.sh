#! /bin/bash
while true; do
echo "----------------------------------------------"
echo "                   MENU                       "
echo "----------------------------------------------"
echo "           1. Create a new file               "
echo "           2. Write to file                   "
echo "           3. Read file                       "
echo "           4. Rename file                     "
echo "           5. Delete file                     "
echo "           6. Update file contents            "
echo "           7. Create folder                   "
echo "           8. Move file to folder             "
echo "           9. Move folder                     "
echo "          10. Delete folder                   "
echo "          11. Encrypt file                    "
echo "          12. Decrypt file                    "
echo "          13. Exit                            "
echo "----------------------------------------------"
echo "Enter choice: "
read x
case $x in
1) read -p "Enter new file name: " newFileName
   touch $newFileName
   chmod +w $newFileName
   chmod +r $newFileName
   echo "File $newFileName created"
   ;;
2) read -p "Enter file name: " fileName
   if [ -e $fileName ]; then
   	echo "Press 'Ctrl+D' to save and close file"
   	cat >> $fileName
   fi
   ;;
3) read -p "Enter file name: " readFile
	if [[ ! -e $readFile ]]  
   then 
	   echo "File does not exist"
	   continue
	fi
	while IFS= read -r line
	do
		echo "$line"
	done < $readFile
   
   ;;
4) read -p "Enter the name of file you want to rename: " renameFile
   if [ -e $renameFile ]
   then
   	read -p "Enter the new file name: " newFileName
	mv $renameFile $newFileName
	echo "The file renaming was successful!"
   else
	echo "File doesn't exist!"
   fi
   ;;
5) read -p "Enter the name of the file you want to delete" deleteFile
   if [ -e $deleteFile ]
   then
	rm -i $deleteFile
	echo "File successfully deleted!"
   else
	echo "File doesn't exist!"
   fi
   ;;
6) read -p "Enter the name of the file to edit " filename
   if [[ ! -e $filename ]]
   then
   	echo "File doesn't exist!"
   	continue
   fi
   echo "Be prepared! An editor will open. There are help instructions in the editor"
   echo "Search online if you get stuck"
   read -p "Press enter to continue"
   nano $filename
   ;;
7) read -p "Enter path. A dot [.] is the current folder " path
   read -p "Enter folder name " name
   if [[ $path == "~" ]]
   then
	path=~
   fi
   if [[ $path == ".." ]]
   then 
	   path=..
   fi
   mkdir $path/$name
   ;;
8) read -p "Enter filename " filename
   read -p "Enter path of folder to move to. .. is parent folder " dest
   mv $filename $dest
   ;;
9) read -p "Enter folder name " sauce
   read -p "Enter path of folder to move to. .. is parent folder " dest
   mv $sauce $dest
   ;;
10) read -p "Enter path to folder " folder
    if find $folder -mindepth 1 -maxdepth 1 | read
    then
	read -p "The folder is not empty. Delete all contents? y/n " choice
	while [[ $choice != "y" && $choice != "n" ]]
	do
		read choice
	done
	if [[ $choice == "y" ]]
	then
		rm -rf $folder
	fi
    else
    	rmdir $folder
    fi
    ;;
11) read -p "Enter file name you'd like to encrypt: " encryptFile
    gpg -c $encryptFile
    rm -rf $encryptFile
    echo "File successfully encrypted"
    echo "Encrypted file now has .gpg extension"
    ;;
12) read -p "Enter full file name you'd like to decrypt with .gpg extension: " decryptFile
	if [[ $decryptFile != *".gpg" ]]
	then
		echo "Not an encrypted file. File should have .gpg extension."
		continue
	fi
    gpg -d $decryptFile > ${decryptFile::-4}
    echo "File successfully decrypted"
    rm $decryptFile
    ;;
13) exit 0
    ;;
esac
done
