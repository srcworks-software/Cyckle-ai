echo "==WARNING BY THE DEVELOPERS=="
echo "This script will remove all files except for the exectuable and json file. If you have not finished setup, PLEASE DO NOT EXECUTE THIS! PRESS CTRL+C WHILE YOU CAN!"
echo "Removal of files will start in 15 seconds, if you want to cancel, press CTRL+C"
sleep 15
echo "Removing files..."
rm main.pyx
rm setup.py
rm Makefile
rm README.md
rm -rf build
rm -rf install
rm -rf .vscode
rm -rf .github
rm .gitattributes
rm LICENSE
rm main.c
echo "Unused files have been cleared."