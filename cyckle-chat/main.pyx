# cython: language_level=3
import cython
import tkinter as tk
from tkinter import PhotoImage as pi
import psutil
from tkinter import simpledialog, messagebox, ttk
from gpt4all import GPT4All
import json

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
    
modtokens = read_tokens_from_json()

physcores, logicores = optimize()
threads = min(logicores, 8)

print(f"[DEBUG] {threads} threads in use.")

data = {
    "tokens": modtokens
}

system_prompt = '''You are Cyckle, a helpful AI assistant. Your responses should be clear, direct, and relevant to the user's questions. Aim to be informative yet concise.'''

cdef object usermodel
usermodel = GPT4All("Phi-3.5-mini-instruct-IQ3_XS.gguf", model_path="models", n_threads=threads)

cpdef void handle_input(event=None):
    global modtokens , cmdhistory, poshistory, usermodel
    cdef str userinput
    userinput = entry.get()

    if userinput.strip():
        cmdhistory.append(userinput)
        poshistory = len(cmdhistory)

    if userinput.lower() == "quit":
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

root = tk.Tk()
root.withdraw() 

def maingui():
    global response_text, entry, label1, main, icon
    splash.destroy()

    # window config
    icon = pi(file="assets/icon.png")
    main = tk.Tk()
    main.iconphoto(True, icon)

    style = ttk.Style(main)
    style.theme_use("clam")
    style.configure("TLabel", foreground="#ffffff", background="#092332")
    style.configure("TEntry", foreground="#ffffff", fieldbackground="#092332", background="#092332")

    main.config(bg="#092332")
    main.title("Cyckle")
    main.resizable(False, False)
    periodic_redraw()

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

    label1 = ttk.Label(master=main, text="YOU>>>")
    label1.config(font=("DejaVu Sans", 20))
    label1.grid(row=0, column=0, sticky="nsew", padx=10, pady=10)

    # text label
    response_text = tk.Text(master=main, wrap=tk.WORD, bg="#1c1c1c", fg="#ffffff", font=("DejaVu Sans", 20), relief=tk.FLAT)
    response_text.grid(row=1, column=0, sticky="nsew", padx=10, pady=10)
    response_text.config(state=tk.DISABLED)

    # entry box
    entry = ttk.Entry(master=main, font=("DejaVu Sans", 15))
    entry.grid(row=2, column=0, sticky="ew", padx=10, pady=10)
    entry.focus_set()
    entry.bind("<Return>", handle_input)

    # redraw system
    main.bind("<Map>", lambda e: force_redraw())
    main.bind("<Visibility>", lambda e: force_redraw())

    main.mainloop()

def force_redraw():
    main.update_idletasks()
    main.update()

def periodic_redraw():
    force_redraw()
    main.after(1000, periodic_redraw)

def center_window(win, width, height):
    screen_width = win.winfo_screenwidth()
    screen_height = win.winfo_screenheight()

    x = (screen_width // 2) - (width // 2)
    y = (screen_height // 2) - (height // 2)

    win.geometry(f"{width}x{height}+{x}+{y}")

splash = tk.Toplevel()
splash.overrideredirect(True)
center_window(splash, 600, 384)
splashimg = pi(file="assets/splash.png")
 
splash_label = tk.Label(splash, image=splashimg)
splash_label.pack()

# start the main loop
splash.after(5000, maingui)

splash.mainloop()