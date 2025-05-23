import tkinter as tk
import tkinter.messagebox as messagebox
import csv
import os

# Define CSV filename
csv_filename = "person.csv"

# Create the main application window
window = tk.Tk()
window.title("Data Entry Form")

# Create labels and entry widgets
tk.Label(window, text="Name").grid(row=0, column=0, padx=5, pady=5, sticky="w")
name_entry = tk.Entry(window)
name_entry.grid(row=0, column=1, padx=5, pady=5)

tk.Label(window, text="Firstname").grid(row=1, column=0, padx=5, pady=5, sticky="w")
firstname_entry = tk.Entry(window)
firstname_entry.grid(row=1, column=1, padx=5, pady=5)

tk.Label(window, text="Email").grid(row=2, column=0, padx=5, pady=5, sticky="w")
email_entry = tk.Entry(window)
email_entry.grid(row=2, column=1, padx=5, pady=5)

tk.Label(window, text="Age").grid(row=3, column=0, padx=5, pady=5, sticky="w")
age_entry = tk.Entry(window)
age_entry.grid(row=3, column=1, padx=5, pady=5)

# Function to retrieve and print data
def submit_data():
    name = name_entry.get()
    firstname = firstname_entry.get()
    email = email_entry.get()
    age = age_entry.get()

    # Basic validation
    if not name or not firstname:
        messagebox.showerror("Error", "Name and Firstname fields cannot be empty.")
        return

    data_row = [name, firstname, email, age]
    file_exists = os.path.exists(csv_filename)

    with open(csv_filename, mode='a' if file_exists else 'w', newline='') as file:
        writer = csv.writer(file)
        if not file_exists:
            writer.writerow(["name", "firstname", "email", "age"])  # Write header
        writer.writerow(data_row)

    # Clear entry fields
    name_entry.delete(0, tk.END)
    firstname_entry.delete(0, tk.END)
    email_entry.delete(0, tk.END)
    age_entry.delete(0, tk.END)

    # Show success message
    messagebox.showinfo("Success", "Data saved successfully!")

# Create the Submit button
submit_button = tk.Button(window, text="Submit", command=submit_data)
submit_button.grid(row=4, column=0, columnspan=2, pady=10)

# Start the main event loop
window.mainloop()
