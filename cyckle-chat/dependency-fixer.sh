sudo apt install -y python3-minimal python3-pip
sudo apt install -y python3.13-dev
sudo apt install -y gcc make build-essential
python3 -m venv venv
source venv/bin/activate
python3 -m pip install -r requirements.txt
make clean
make 
clear
echo "==INSTALLATION COMPLETE=="
echo "You can do the following to run Cyckle:"
echo "Type 'make run'"
sudo chmod +x clean.sh