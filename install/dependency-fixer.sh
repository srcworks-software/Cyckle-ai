sudo apt install -y python3 python3-pip
sudo apt install -y python3.13-dev
sudo apt install -y gcc make build-essential
pip install gpt4all --break-system-packages
clear
echo "==PyLLM UNATTENDED INSTALLATION=="
python3 -m wizard.py
echo "==INSTALLATION COMPLETE=="
echo "Type 'python3 -m main.py' to use PyLLM"
echo "or execute the main executable."
