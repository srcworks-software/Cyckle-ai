import cython
import tkinter as tk
from tkinter import simpledialog, messagebox
from gpt4all import GPT4All
import json
from install.wizard import usedmodel

def read_tokens_from_json():
    try:
        with open("data.json", "r") as f:
            data = json.load(f)
            return data.get("tokens", 96)  
    except FileNotFoundError:
        return 96  # Just in case... juuuust in case... actually why the hell would you delete the json? 
modtokens = read_tokens_from_json()

usermodel = usedmodel

data = {
    "tokens" : modtokens
}

# functions, the backbone of python
def handle_input(event=None):
    global modtokens  # hell yeah i love global variables
    userinput = entry.get()
    if userinput.lower() in ["exit", "quit"]:
        main.quit()
    elif userinput.lower() == "modtokens":
        current_limit = f'Current token limit is set to {modtokens}'
        warning = 'WARNING: HIGHER TOKEN LIMITS MAY CAUSE HIGHER USAGE OF RESOURCES! DO THIS AT YOUR OWN RISK.'
        messagebox.showinfo("Modtokens", f"{current_limit}\n{warning}")
        new_limit = simpledialog.askinteger("Modtokens", "Enter new token limit:")
        if new_limit is not None:
            modtokens = new_limit
            data["tokens"] = modtokens
            messagebox.showinfo("Modtokens", f"Token limit has been set to {modtokens}")
            filename = "data.json"
            with open(filename, 'w') as f:
                json.dump(data, f, indent=4)
    elif userinput.lower() == "help":
        help_message = (
            'Type "exit" or "quit" to leave the program.\n'
            '\n'
            'Type "modtokens" to change the token limit.\n'
            '\n'
            'Type "about" to learn more about this program.\n'
            '\n'
            f'MODTOKEN PARAM IS CURRENTLY SET TO: {modtokens}'
        )
        messagebox.showinfo("Help", help_message)
    elif userinput.lower() == "about":
        about_message = (
            'Cyckle - Another GPT-4 wrapper.\n'
            'Licensed under MIT \n'
            'See the source code at: https://github.com/vaultdweller-2287/Cyckle'
        )
        messagebox.showinfo("About", about_message)
    else:
        with usermodel.chat_session():
            response = usermodel.generate(userinput, max_tokens=modtokens)
            response_text.config(state=tk.NORMAL)
            response_text.delete(1.0, tk.END)
            response_text.insert(tk.END, "Cyckle>>> " + response)
            response_text.config(state=tk.DISABLED)
            label1.config(text="YOU>>> " + userinput)
    entry.delete(0, tk.END)

# init something something window
main = tk.Tk()
main.config(bg="#323236")
main.title("Cyckle")

# grids or something idk
main.grid_rowconfigure(0, weight=1)
main.grid_rowconfigure(1, weight=1)
main.grid_rowconfigure(2, weight=0)
main.grid_columnconfigure(0, weight=1)

# label widget for input display
label1 = tk.Label(master=main, text="YOU>>>")
label1.config(bg="#313438", fg="#ffffff", font=("TkDefaultFont", 20))
label1.grid(row=0, column=0, sticky="nsew", padx=10, pady=10)

# text widget for response
response_text = tk.Text(master=main, wrap=tk.WORD, bg="#353a40", fg="#ffffff", font=("TkDefaultFont", 20))
response_text.grid(row=1, column=0, sticky="nsew", padx=10, pady=10)
response_text.config(state=tk.DISABLED)  # Make the Text widget read-only

# entry widget
entry = tk.Entry(master=main, text="Type here...")
entry.config(bg="#4e4e4e", fg="#000", relief=tk.GROOVE, font=("TkDefaultFont", 15), cursor="hand2")
entry.grid(row=2, column=0, sticky="ew", padx=10, pady=10)
entry.bind("<Return>", handle_input)  # Bind the Enter key to handle_input function

# start the main loop
main.mainloop()
