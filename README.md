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

---

# Zorin OS Last 3 User Sessions Script

This shell script, `get_last_sessions.sh`, displays the start time, end time, and duration of the last three completed login sessions for the user 'gecko' on a Zorin OS (or other Ubuntu-based Linux) system.

## Requirements

- A Linux system with standard shell commands (bash, last, grep, awk, date, sort, head).
- The script is configured for the username 'gecko'. To use for a different user, the `USERNAME` variable within the script must be modified.

## How to Run

1.  Ensure the script `get_last_sessions.sh` has execute permissions. If not, run:
    ```bash
    chmod +x get_last_sessions.sh
    ```
2.  Execute the script from your terminal:
    ```bash
    ./get_last_sessions.sh
    ```

## Output

The script will print the details for up to the last three completed sessions for the user 'gecko'. Each line will be in the format:

`Session Start: [Start Time], End: [End Time], Duration: [HH:MM:SS]`

If fewer than three sessions are found, it will display information for those available. If no completed sessions are found, it will print a message indicating so.

**Example Output:**
```
Session Start: Mon Dec 11 10:00:00 2023, End: Mon Dec 11 12:30:00 2023, Duration: 02:30:00
Session Start: Sun Dec 10 15:00:00 2023, End: Sun Dec 10 18:00:00 2023, Duration: 03:00:00
Session Start: Fri Dec  8 11:00:00 2023, End: Fri Dec  8 17:00:00 2023, Duration: 06:00:00
```
*(Note: Actual date/time values will vary based on system logs.)*
