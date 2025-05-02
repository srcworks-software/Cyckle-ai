sudo apt install -y python3-minimal python3-pip
sudo apt install -y python3.13-dev
sudo apt install -y gcc make build-essential
sudo apt install -y wget
cd models
wget https://huggingface.co/bartowski/Phi-3.5-mini-instruct-GGUF/resolve/main/Phi-3.5-mini-instruct-IQ3_XS.gguf
wget https://huggingface.co/abetlen/Phi-3.5-vision-instruct-gguf/resolve/main/Phi-3.5-3.8B-vision-instruct-mmproj-F16.gguf
cd -
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