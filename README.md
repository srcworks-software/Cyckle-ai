# Cyckle
![Alt text](https://github.com/vaultdweller-2287/Cyckle-ai/blob/main/.github/cycklelogo.jpg)

A graphical Phi3 wrapper built with the gpt4all python library that is locally run and utilizes cython (C-extensions for python).

# Installation

This is currently the easiest method to install Cyckle.

## Compile it from source

As the title says, this method requires you to compile Cyckle from source. This is pretty easy as it utilizes makefile.

### Step 1: Download prerequisites

The files needed for this are:
- ```makefile```
- ```dependency-fixer.sh``` 
- ```main.c```
- ```setup.py```
You are going to want to run ```git clone``` to obtain these.
```bash
    git clone https://github.com/vaultdweller-2287/Cyckle-ai
```
Or, you could download the source code file from the release notes in this github repo.

If you do not have git installed, run the following (depends on your distro, but this is optimized for debian.):
```bash
    sudo apt install git
```
### Step 2: Install dependencies

Before we start, ```cd``` into the folder you cloned the repo in.
```bash
    cd Cyckle-ai
```
You will need to install the required dependencies through ```dependency-fixer```. Here's how to do it:
```bash
    sudo chmod +x dependency-fixer.sh
    sudo ./install/dependency-fixer.sh
```
The required dependencies will be installed along with the compilation of ```main.c```.

### Step 3: Cleaning

Once everything is done, you may want to tidy up the directory, which can be done like so:
```bash
    sudo chmod +x clean.sh
    sudo ./clean.sh
```
### Step 4: Running

Execute the executable through makefile.
```bash
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
Despite using the *GPT*4all library, it actually utilizes ```phi3``` as it's model. We do not plan on adding anymore, though the model itself may change as we aim to have a more lightweight approach to local LLMs (or really, SLMs in our case).

## Will Cyckle be packaged into my distro's package repos?
Currently, any and all packaging systems have been SEVERELY painful to set up. So for as long as that is true, don't expect an easy-to-install Cyckle.

## What system do I need for Cyckle?
The exact specifications are not known but gpt4all requires any processor with AVX2 (Intel i3 2nd gen/AMD FX-4100 or above). The testing hardware was conducted on an i5-7200u with integrated graphics. RAM is also recommended to be around 8 or more gigabytes just to be safe.

# NOTICE
This software is provided subject to the MIT License and may be republished or distributed only in accordance with the terms of the MIT License. 
This software includes third party elements used under an applicable MIT License and this NOTICE represents the required disclosure and notice concerning publication and use of such elements under the applicable MIT License.   
