# cython: language_level=3
import cython
import tkinter as tk
import psutil
import multiprocessing
from tkinter import simpledialog, messagebox
from gpt4all import GPT4All
import json

cdef int modtokens
cdef tuple optimize():
    cdef int physcores = psutil.cpu_count(logical=False)
    cdef int logicores = psutil.cpu_count(logical=True)
    return physcores, logicores

cdef list cmdhistory = []
cdef int poshistory = -1

# json things
cdef int read_tokens_from_json():
    cdef dict data
    try:
        with open("data.json", "r") as f:
            data = json.load(f)
            return data.get("tokens", 96) 
    except FileNotFoundError:
        return 256 

modtokens = read_tokens_from_json()

physcores, logicores = optimize()
threads = min(logicores, 8)


usermodel = GPT4All("Phi-3-mini-4k-instruct.Q4_0.gguf")

data = {
    "tokens": modtokens
}

system_prompt = '''You are Cyckle, a helpful AI assistant. Your responses should be clear, direct, and relevant to the user's questions. Aim to be informative yet concise.'''

cpdef void handle_input(event=None):
    global modtokens , cmdhistory, poshistory
    cdef str userinput
    userinput = entry.get()

    if userinput.strip():
        cmdhistory.append(userinput)
        poshistory = len(cmdhistory)

    if userinput.lower() in ["exit", "quit"]:
        main.quit()

    elif userinput.lower() == "modtokens":
        current_limit = f'Current token limit is set to {modtokens}'
        warning = 'WARNING: HIGHER TOKEN LIMITS MAY CAUSE HIGHER USAGE OF RESOURCES! DO THIS AT YOUR OWN RISK.'
        messagebox.showwarning("Modtokens", f"{current_limit}\n{warning}")
        new_limit = simpledialog.askinteger("Modtokens", "Enter new token limit:")
        if new_limit is not None:
            modtokens = new_limit
            data["tokens"] = modtokens  
            messagebox.showinfo("Modtokens", f"Token limit has been set to {modtokens}")
            filename = "data.json"  
            with open(filename, 'w') as f:
                json.dump(data, f, indent=4)
        else:
            messagebox.showerror("Modtokens", f'The entry "{new_limit}" is not a valid integer. Please try again.')

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
            'Cyckle - Lightweight Phi3-mini wrapper.\n'
            'Licensed under MIT \n'
            'See the source code at: https://github.com/vaultdweller-2287/Cyckle-ai'
        )
        messagebox.showinfo("About", about_message)
    else:
        with usermodel.chat_session(system_prompt=system_prompt):
            response = usermodel.generate(userinput, max_tokens=modtokens, temp=0.3, top_k=25, top_p=0.9, repeat_penalty=1.1, n_batch=8)
            response_text.config(state=tk.NORMAL)
            response_text.delete(1.0, tk.END)
            response_text.insert(tk.END, "Cyckle>>> " + response)
            response_text.config(state=tk.DISABLED)
            label1.config(text="YOU>>> " + userinput)
    entry.delete(0, tk.END)

cpdef void handle_history(event):
    global poshistory
    
    if event.keysym == "Up":
        if poshistory > 0:
            poshistory -= 1
            entry.delete(0, tk.END)
            entry.insert(0, cmdhistory[poshistory])
    elif event.keysym == "Down":
        if poshistory < len(cmdhistory) - 1:
            poshistory += 1
            entry.delete(0, tk.END)
            entry.insert(0, cmdhistory[poshistory])
        else:
            poshistory = len(cmdhistory)
            entry.delete(0, tk.END)


# window config
main = tk.Tk()
main.config(bg="#323236")
main.title("Cyckle")
main.resizable(False, False)

# window geometries
sw = main.winfo_screenwidth()
sh = main.winfo_screenheight()
swutil = sw*0.8
shutil = sh*0.9
main.geometry(f"{int(swutil)}x{int(shutil)}+50+50")

# grid config
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
response_text.config(state=tk.DISABLED) 

# entry widget
entry = tk.Entry(master=main, text="Type here...")
entry.config(bg="#4e4e4e", fg="#000", relief=tk.GROOVE, font=("TkDefaultFont", 15), cursor="hand2")
entry.grid(row=2, column=0, sticky="ew", padx=10, pady=10)
entry.bind("<Return>", handle_input) 
entry.bind("<Up>", handle_history)
entry.bind("<Down>", handle_history)

# start the main loop
main.mainloop()
