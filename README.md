# Cyckle
A graphical GPT4 wrapper built with the gpt4all python library that is locally run and utilizes cython (C-extensions for python).
# Installation
There are lots of methods to install and run Cyckle but I will keep it rational and use the most sensible one.
## Compile it from source
As the title says, this method requires you to compile Cyckle from source. This is pretty easy as it utilizes makefile.
### Step 1: Download prerequisites
The files needed for this are:
- ```makefile``` (found in /install)
- ```wizard.py``` (found in /install)
- ```dependency-fixer.sh``` (found in /install)
- ```main.c```
- ```script.py```
You are going to want to run ```git clone``` to obtain these.
```
    git clone https://github.com/vaultdweller-2287/Cyckle-ai
```
Or, you could download the ```bin.tar``` file from the release notes in this github repo.

If you do not have git installed, run the following (depends on your distro, but this is optimized for debian.):
```
    sudo apt install git
```
### Step 1.1 putting python PATH in your .zshrc or .bashrc file
Before running ```dependency-fixer```, you will need to add the following line to your ```.zshrc``` or ```.bashrc``` file.
Run the following to access it:
```
    sudo nano ~/.zshrc
```
Once you have opened this file, add this line at the bottom:
```
    export PYTHONPATH=/home/user/directory/Cyckle-ai:$PYTHONPATH
```
Replace ```user``` with your username and replace ```directory``` with the directory in which you have cloned the git repo of Cyckle.
### Step 2: Install dependencies
Before we start, ```cd``` into the folder you cloned the repo in.
```
    cd Cyckle-ai
```
You will need to install the required dependencies through ```dependency-fixer```. Here's how to do it:
```
    sudo chmod +x install/dependency-fixer.sh
    sudo ./install/dependency-fixer.sh
```
The follow dependencies will be installed.
### Step 2.1 Unattended install wizard
The ```wizard.py``` file will autorun once ```dependency-fixer``` is done. It will download the LLM files for Cyckle.
### Step 3 Compile!
In your terminal, run the following:
```
    make
```
This will compile ```main.c``` into an exectuble which can be found inside the folder.

# Parameters/Commands
The following parameters and commands will display and modify different information.
## Token Modifier
In order to modify the amount of tokens in Cyckle, type ```modtokens``` in the message box. It will pull up a window where you can modify the modtoken parameter. This does not save if you close the program, well at least not yet ;).
## Quit/Exit
Pretty self-explanatory, quits the program. Type ```quit``` or ```exit``` to execute this.
## About
Once again, pretty self-explanatory, shows details about the program. Type ```about``` to execute this.
## Help
Provides a glossary for parameters and commands. type ```help``` to execute this.

# FAQ (Frequently Asked Questions)
These are some questions that are probably never asked but just incase they are, here you go.
## What model does Cyckle use?
Despite using the *GPT*4all library, it actually utilizes ```llamacpp``` as it's model. However, we are planning to add the option to use a different model in the installer.
## Will Cyckle be packaged into my distro's package repos?
We are not sure about distro packaging yet but we are certain that Cyckle will be packaged sooner rather than later for Debian and maybe Ubuntu.
## What system do I need for Cyckle?
The exact specifications are not known but gpt4all requires any processor with AVX2 (Intel i3 2nd gen). The testing hardware was conducted on an i5-7200u with integrated graphics.

# NOTICE
This software is provided subject to the MIT License and may be republished or distributed only in accordance with the terms of the MIT License. 
This software includes third party elements used under an applicable MIT License and this NOTICE represents the required disclosure and notice concerning publication and use of such elements under the applicable MIT License.   
