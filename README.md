# Data Entry Form Application

This application provides a simple graphical user interface (GUI) to enter data for individuals (Name, Firstname, Email, Age) and saves it into a CSV file named `person.csv`.

## Requirements

- Python 3.x
- Tkinter (usually included with standard Python installations)

## How to Run

1.  Ensure you have Python 3 installed on your system.
2.  Open a terminal or command prompt.
3.  Navigate to the directory where `data_entry_form.py` is located.
4.  Run the script using the command:
    ```bash
    python data_entry_form.py
    ```

## Output

The data entered through the form will be saved in a file named `person.csv`. This file will be created in the same directory where the script is executed. If the file already exists, new data will be appended to it.

The CSV file will have the following columns:
- name
- firstname
- email
- age
