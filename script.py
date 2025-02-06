import cython
import tkinter as tk
from tkinter import simpledialog, messagebox
from gpt4all import GPT4All

model = GPT4All("Meta-Llama-3-8B-Instruct.Q4_0.gguf")  # downloads / loads a 4.66GB LLM
modtokens = 96

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
            messagebox.showinfo("Modtokens", f"Token limit has been set to {modtokens}")
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
            'CyLLM - Another GPT-4 wrapper.\n'
            'See the source code at: https://github.com/vaultdweller-2287/CyLLM'
        )
        messagebox.showinfo("About", about_message)
    else:
        with model.chat_session():
            response = model.generate(userinput, max_tokens=modtokens)
            response_text.config(state=tk.NORMAL)
            response_text.delete(1.0, tk.END)
            response_text.insert(tk.END, "GPT>>> " + response)
            response_text.config(state=tk.DISABLED)
            label1.config(text="YOU>>> " + userinput)
    entry.delete(0, tk.END)

# init something something window
main = tk.Tk()
main.config(bg="#323236")
main.title("CyLLM")

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
