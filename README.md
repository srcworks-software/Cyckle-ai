# Cyckle
![Alt text](https://github.com/vaultdweller-2287/Cyckle-ai/blob/main/.github/cycklelogo.jpg)

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

### Step 3: Compile!
In your terminal, run the following:
```
    make
```
This will compile ```main.c``` into several binaries necessary for running Cyckle.

### Step 3.1: INCASE OF ERROR!
If you get an error like:
```
    make: Nothing to be done for 'all'.
```
You will need to run the following:
```
    make clean
```
This will clean the directory and will prepare it for compilation. Once you have ran this, repeat step 3.

### Step 3.2: cleaning

Once everything is done, you may want to tidy up the directory, which can be done like so:
```
    sudo chmod +x clean.sh
```
```
    sudo ./clean.sh
```
### Step 4: Running

Due to some very strange side effects of a patch we made to fix a header issue in ```main.c```, there is now only one way to run Cyckle. 

```
    make run
```

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
Despite using the *GPT*4all library, it actually utilizes ```orca-mini``` (a llama based model) as it's model. We do not plan on adding anymore, though the model itself may change as we aim to have a more lightweight approach to local LLMs.
## Will Cyckle be packaged into my distro's package repos?
For the future we do plan on packaging for Debian 13 (Trixie) but we do not have plans for other distros.
## What system do I need for Cyckle?
The exact specifications are not known but gpt4all requires any processor with AVX2 (Intel i3 2nd gen). The testing hardware was conducted on an i5-7200u with integrated graphics.

# NOTICE
This software is provided subject to the MIT License and may be republished or distributed only in accordance with the terms of the MIT License. 
This software includes third party elements used under an applicable MIT License and this NOTICE represents the required disclosure and notice concerning publication and use of such elements under the applicable MIT License.   
