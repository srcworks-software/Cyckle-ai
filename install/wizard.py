from gpt4all import GPT4All

def setup_model():
    print('===MODEL SETUP AND DOWNLOAD===')
    print('Please enter a number from the list below to select a model that you would like to use with Cyckle.')
    print('(1) Meta-Llama-3-8B-Instruct.Q4_0 (default)')
    print('(2) orca-mini-3b-gguf2-q4_0 (lightweight)')
    print('(3) Phi-3-mini-4k-instruct.Q4_0 (reasoning)')
    usermodel = input('Enter here:')

    if usermodel == "1":
        return GPT4All('Meta-Llama-3-8B-Instruct.Q4_0.gguf')
    elif usermodel == "2":
        return GPT4All('orca-mini-3b-gguf2-q4_0.gguf')
    elif usermodel == "3":
        return GPT4All('Phi-3-mini-4k-instruct.Q4_0.gguf')
    else:
        print('Input invalid. Please restart wizard.py')
        exit()

if __name__ == "__main__":
    usedmodel = setup_model()
    print("Model setup complete.")