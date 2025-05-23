#!/bin/bash

USERNAME="gecko"
SESSION_DATA_TEMP=$(mktemp)

# Fetch and process session data
# -Fw prints full times and dates
# We grep for lines starting with USERNAME and containing a hyphen (separator for start/end times)
# We exclude "still logged in" and "gone - no logout" as they don't have a valid end time for this parsing method
last -Fw "$USERNAME" | grep -E "^$USERNAME\s+.*\s+-\s+.*\([0-9]{2}:[0-9]{2}\)$" | while IFS= read -r line; do
    # Extract parts using string manipulation or awk. Awk is better for field splitting.
    # We need to robustly find the start and end date strings.
    # The hyphen separates start and end times. Dates are typically 5 fields.
    # Example: gecko pts/0        192.168.1.100    Mon Dec 11 10:00:00 2023 - Mon Dec 11 12:30:00 2023  (02:30)
    #                                          [----start date string----]   [----end date string----]

    # Use awk to find the hyphen and extract the 5 fields before and 5 fields after
    # This assumes date strings are always 5 components: Day Mon Date Time Year
    start_date_str=$(echo "$line" | awk -F ' - ' '{print $1}' | awk '{OFS=" "; print $(NF-4), $(NF-3), $(NF-2), $(NF-1), $NF}')
    end_date_str=$(echo "$line" | awk -F ' - ' '{print $2}' | awk '{OFS=" "; print $1, $2, $3, $4, $5}')

    # Convert to epoch seconds
    # Adding 2>/dev/null to suppress errors from `date` if parsing fails
    start_epoch=$(date -d "$start_date_str" +%s 2>/dev/null)
    end_epoch=$(date -d "$end_date_str" +%s 2>/dev/null)

    # If conversion was successful (date returns 0 and epoch is not empty)
    if [ -n "$start_epoch" ] && [ -n "$end_epoch" ] && [ "$start_epoch" -le "$end_epoch" ]; then
        duration_seconds=$((end_epoch - start_epoch))
        
        h=$((duration_seconds / 3600))
        m=$(((duration_seconds % 3600) / 60))
        s=$((duration_seconds % 60))
        formatted_duration=$(printf "%02d:%02d:%02d" "$h" "$m" "$s")
        
        # Store end_epoch, start_date_str, end_date_str, formatted_duration
        # Quoting date strings to handle spaces
        echo "$end_epoch \"$start_date_str\" \"$end_date_str\" $formatted_duration" >> "$SESSION_DATA_TEMP"
    fi
done

# Check if any sessions were recorded
if [ ! -s "$SESSION_DATA_TEMP" ]; then
    echo "No completed sessions found for user $USERNAME."
    rm -f "$SESSION_DATA_TEMP"
    exit 0
fi

# Sort by end_epoch (first field) numerically in reverse order, then take top 3
sort -k1,1nr "$SESSION_DATA_TEMP" | head -n 3 | while IFS=' ' read -r end_epoch_val start_str_quoted end_str_quoted duration_fmt; do
    # Remove quotes for final display
    start_str_unquoted=$(echo "$start_str_quoted" | sed 's/"//g')
    end_str_unquoted=$(echo "$end_str_quoted" | sed 's/"//g')
    echo "Session Start: $start_str_unquoted, End: $end_str_unquoted, Duration: $duration_fmt"
done

# Clean up
rm -f "$SESSION_DATA_TEMP"
exit 0
