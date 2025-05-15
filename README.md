![Alt text](https://github.com/srcworks-software/Cyckle-ai/blob/main/.github/cycklelogo.jpg)

![GitHub Repo stars](https://img.shields.io/github/stars/srcworks-software/Cyckle-ai?style=for-the-badge)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/srcworks-software/Cyckle-ai?style=for-the-badge)
![GitHub license](https://img.shields.io/github/license/srcworks-software/Cyckle-ai?style=for-the-badge)

# Cyckle Chat

The graphical chatbot interface of Cyckle.

## Installation

This is currently the easiest method to install Cyckle.

### Compile it from source

As the title says, this method requires you to compile Cyckle from source. This is pretty easy as it utilizes makefile.

#### Step 1: Install dependencies

Before we start, paste in the following command:
```bash
    git clone https://github.com/srcworks-software/Cyckle-ai
```

```bash
    cd Cyckle-ai/cyckle-chat
    sudo chmod +x dependency-fixer.sh
    sudo ./dependency-fixer.sh
```

#### Step 1.1: Cleaning

If you would like to clean up the directory, do the following:
```bash
    sudo ./clean.sh
```

#### Step 2: Running

Execute the executable through makefile.
```bash
    make run
```

### Parameters/Commands
The following parameters and commands will display and modify different information.

#### Token Modifier
In order to modify the amount of tokens in Cyckle, type ```modtokens``` in the message box. It will pull up a window where you can modify the modtoken parameter. This saves to a file named ```data.json```.

#### Quit
Pretty self-explanatory, quits the program. Type ```quit``` to execute this.

#### CSV Analysis
You can have Cyckle analyze the information of a CSV file. To get started, click the "Analyze CSV" button below the entry box, choose the desired file in the pop-up window, and Cyckle will start analyzing! 

## FAQ (Frequently Asked Questions)
These questions were never actually asked, but I just wanted to clarify some information.

#### What model does Cyckle use?
Despite using the *GPT*4all library, it actually utilizes the ```phi``` family of models.

#### Will Cyckle be packaged into my distro's package repos?
Currently, any and all packaging systems have been SEVERELY painful to set up. So for as long as that is true, don't expect an easy-to-install Cyckle.

#### What system do I need for Cyckle?
These days, you could run it on almost anything!

| Specs | Minimum | Recommended |
|-------|---------|-------------|
| CPU   | Intel Sandy Bridge/AMD Bulldozer | Intel Haswell/AMD Excavator |
| RAM   | 4GB | 8GB |
| GPU   | Integrated | Dedicated |

***Note*** - While Cyckle was tested on Debian 13, I believe all of the dependencies will work on Debian 12. If not, let me know!

# Cyckle Developer Handbook
If you are interested in developing, contributing, or just want a better understanding of Cyckle's source code, check out our Jupyter Notebook file in the ```handbook/``` directory! 

# Contributing
Read our ```CONTRIBUTING.md``` for information regarding contributions to Cyckle.

# NOTICE
This software is provided subject to the MIT License and may be republished or distributed only in accordance with the terms of the MIT License. 
This software includes third party elements used under an applicable MIT License and this NOTICE represents the required disclosure and notice concerning publication and use of such elements under the applicable MIT License.   
