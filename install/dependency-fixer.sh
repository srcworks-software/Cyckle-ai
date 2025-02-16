sudo apt install -y python3 python3-pip
sudo apt install -y python3.13-dev
sudo apt install -y gcc make build-essential
pip install gpt4all --break-system-packages
pip install cython --break-system-packages
clear
echo "==Cyckle SETUP=="
echo "Beginning"
python3 -m wizard.py
echo "==INSTALLATION COMPLETE=="
echo "Please run the following command to finish setup:"
echo "nano ~/.zshrc"
echo "Add the following line to the bottom of the file:"
echo "export PYTHONPATH=/home/user/Projects/Cyckle-ai:$PYTHONPATH"
echo "Remember to replace 'user' with your username that is used with your home directory."
echo "Once done, you can do the following to run Cyckle:"
echo "Type 'python3 -m script.pyx'"
echo "or execute the 'main' executable."
