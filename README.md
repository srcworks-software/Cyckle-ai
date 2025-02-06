# CyLLM
A TUI/CLI GPT4 wrapper built with the gpt4all python library that is locally run and utilizes cython (C-extensions for python).
# Installation
There are lots of methods to install and run CyLLM but I will keep it rational and use the most sensible one.
## Compile it from source
As the title says, this method requires you to compile CyLLM from source. This is pretty easy as it utilizes makefile.
### Step 1: Download prerequisites
The files needed for this are:
- ```makefile``` (found in /install)
- ```wizard.py``` (found in /install)
- ```dependency-fixer.sh``` (found in /install)
- ```main.c```
- ```script.py```
Once you have downloaded these files from the repo, put them all in a folder (call it CyLLM or whatever)
### Step 2: Install dependencies
You will need to install the required dependencies through ```dependency-fixer```. Here's how to do it:
```
    sudo chmod +x dependency-fixer.sh
    sudo ./dependency-fixer.sh
```
The follow dependencies will be installed.
### Step 2.1 Unattended install wizard
The ```wizard.py``` file will autorun once ```dependency-fixer``` is done. It will download the LLM files for CyLLM.
### Step 3 Compile!
In your terminal, run the following:
```
    make
```
This will compile ```main.c``` into an exectuble which can be found inside the folder.
# Parameters
We may only have one parameter so far, but at least we have one!
## Token Modifier
In order to modify the amount of tokens in CyLLM, type ```modtokens``` in the message box. It will pull up a window where you can modify the modtoken parameter. This does not save if you close the program, well at least not yet ;).
