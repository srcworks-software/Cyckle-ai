sudo apt install -y python3 python3-pip
sudo apt install -y python3.13-dev
sudo apt install -y gcc make build-essential
pip install gpt4all --break-system-packages
pip install cython --break-system-packages
clear
echo "==INSTALLATION COMPLETE=="
echo "You can do the following to run Cyckle:"
echo "Type 'python3 -m script.pyx'"
echo "or execute the 'main' executable."
