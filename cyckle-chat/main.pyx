# cython: language_level=3
import cython
import tkinter as tk
import psutil
from tkinter import simpledialog, messagebox
from gpt4all import GPT4All
import json

cdef public dict modeldict
modeldict = {
    "Llama-3.2-1B": {
        "model": "Llama-3.2-1B-Instruct-Q4_0.gguf",
        "id": "llama3",
        "purpose": "Ultra-light model for creative tasks."
    },
    "Phi3-mini": {
        "model": "Phi-3-mini-4k-instruct.Q4_0.gguf",
        "id": "phi3",
        "purpose": "Lightweight model for logical and reasoning tasks."
    }
}

cdef int modtokens
cdef tuple optimize():
    cdef int physcores = psutil.cpu_count(logical=False)
    cdef int logicores = psutil.cpu_count(logical=True)
    return physcores, logicores

cdef list cmdhistory = []
cdef int poshistory = -1

# token JSON function
cdef int read_tokens_from_json():
    cdef dict data
    try:
        with open("data.json", "r") as f:
            data = json.load(f)
            return data.get("tokens", 96) 
    except FileNotFoundError:
        return 256 

cdef str read_model_from_pxi():
    cdef dict model_data
    cdef list model_priority = ["Phi3-mini", "Llama-3.2-1B"]

    for model_name in model_priority:
        model_data = modeldict.get(model_name)
        if model_data:
            print(f"[DEBUG] Using model: {model_data['id']}")
            return model_data['model']
        
    messagebox.showerror("Models", 'Models failed to initialize. Please try again.')
    return "Phi-3-mini-4k-instruct.Q4_0.gguf"
    
modtokens = read_tokens_from_json()

physcores, logicores = optimize()
threads = min(logicores, 8)

# normally using Phi-3-mini-4k-instruct.Q4_0.gguf
model = read_model_from_pxi()
cdef object usermodel = None
if usermodel is None:
    usermodel = GPT4All(model, model_path="models", n_threads=threads)

print(f"[DEBUG] {threads} threads in use.")

data = {
    "tokens": modtokens
}

system_prompt = '''You are Cyckle, a helpful AI assistant. Your responses should be clear, direct, and relevant to the user's questions. Aim to be informative yet concise.'''

cpdef void handle_input(event=None):
    global modtokens , cmdhistory, poshistory, usermodel
    cdef str userinput
    userinput = entry.get()

    if userinput.strip():
        cmdhistory.append(userinput)
        poshistory = len(cmdhistory)

    if userinput.lower() in ["exit", "quit"]:
        main.quit()

    elif userinput.lower() == "modelconfig":
        global model
        model_config = f'Current model configuration: {model}\n'
        warning = 'WARNING: Changing the model may affect performance and behavior.'
        messagebox.showwarning("Model Config", f"{model_config}\n{warning}")
        new_model = simpledialog.askstring("Model Config", "Enter new model name:")

        if new_model:
            for model_name, model_info in modeldict.items():
                if new_model.lower() == model_name.lower():
                    model = model_info['model']  # Update the model variable
                    usermodel = GPT4All(model, model_path="models", n_threads=threads)  # Reinitialize the usermodel with the new model
                    messagebox.showinfo("Model Config", f"Model parameter has been set to: {model_info['id']}")
                else:
                    messagebox.showerror("Model Config", f'The entry "{new_model}" is not a valid model name. Please try again.')

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

def force_redraw():
    main.update_idletasks()
    main.update()

def periodic_redraw():
    force_redraw()
    main.after(1000, periodic_redraw)

# window config
main = tk.Tk()
main.config(bg="#092332")
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
label1.config(bg="#374c58", fg="#ffffff", font=("DejaVu Sans", 20))
label1.grid(row=0, column=0, sticky="nsew", padx=10, pady=10)

# text widget for response
response_text = tk.Text(master=main, wrap=tk.WORD, bg="#374c58", fg="#ffffff", font=("DejaVu Sans", 20))
response_text.grid(row=1, column=0, sticky="nsew", padx=10, pady=10)
response_text.config(state=tk.DISABLED) 

# entry widget
entry = tk.Entry(master=main, text="Type here...")
entry.config(bg="#374c58", fg="#ffffff", relief=tk.GROOVE, font=("DejaVu Sans", 15), cursor="hand2")
entry.grid(row=2, column=0, sticky="ew", padx=10, pady=10)
entry.bind("<Return>", handle_input) 
entry.bind("<Up>", handle_history)
entry.bind("<Down>", handle_history)

# redraw system
main.bind("<Map>", lambda e: force_redraw())
main.bind("<Visibility>", lambda e: force_redraw())
periodic_redraw()

# start the main loop
main.mainloop()
