from gpt4all import GPT4All
model = GPT4All("Meta-Llama-3-8B-Instruct.Q4_0.gguf") # downloads / loads a 4.66GB LLM

modtokens = 96
print('[PyLLM] LLM word limit is set to the default', modtokens, 'tokens. Type "modtokens" to change this.')

while True:
    userinput = input("[YOU]> ")
    if userinput.lower() == "exit":
        break
    if userinput.lower() == "quit":
        break
    if userinput.lower() == "modtokens":
        print('Current token limit is set to', modtokens)
        print('WARNING: HIGHER TOKEN LIMITS MAY CAUSE HIGHER USAGE OF RESOURCES! DO THIS AT YOUR OWN RISK.')
        modtokens = int(input("[MODTOKEN]>"))
        print('Token limit has been set to', modtokens)
        continue
    if userinput.lower() == "help":
        print('Type "exit" or "quit" to leave the program.')
        print('Type "modtokens" to change the token limit.')
        print('Type "about" to learn more about this program.')
        print('MODTOKEN PARAM IS CURRENTLY SET TO:', modtokens)
        continue
    if userinput.lower() == "about":
        print('PyLLM - Another GPT-4 wrapper.')
        print('See the source code at: https://github.com/vaultdweller-2287/PyLLM')
        continue
    else:
        with model.chat_session():
            print(model.generate(userinput, max_tokens=modtokens))
