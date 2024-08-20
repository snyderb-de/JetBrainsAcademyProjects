#!/bin/bash

# Print the welcome message
echo "Hello $USER!"

# Function to print the main menu
print_menu() {
    echo "------------------------------"
    echo "| Hyper Commander            |"
    echo "| 0: Exit                    |"
    echo "| 1: OS info                 |"
    echo "| 2: User info               |"
    echo "| 3: File and Dir operations |"
    echo "| 4: Find Executables        |"
    echo "------------------------------"
}

# Function to print the file menu
print_file_menu() {
    echo "---------------------------------------------------"
    echo "| 0 Main menu | 'up' To parent | 'name' To select |"
    echo "---------------------------------------------------"
}

# Function to print the file options menu
print_file_options_menu() {
    echo "---------------------------------------------------------------------"
    echo "| 0 Back | 1 Delete | 2 Rename | 3 Make writable | 4 Make read-only |"
    echo "---------------------------------------------------------------------"
}

# Function to list files and directories
list_files_and_directories() {
    echo "The list of files and directories:"
    arr=(*)  # Use globbing to get the list of files and directories
    for item in "${arr[@]}"; do
        if [[ -f "$item" ]]; then
            echo "F $item"
        elif [[ -d "$item" ]]; then
            echo "D $item"
        fi
    done
}

# Function to handle file operations
handle_file_operations() {
    local filename="$1"
    while true; do
        print_file_options_menu
        read -p "> " file_option

        case $file_option in
            0)
                return
                ;;
            1)
                rm "$filename"
                echo "$filename has been deleted."
                return
                ;;
            2)
                echo "Enter the new file name: " 
                read -p "" new_filename
                mv "$filename" "$new_filename"
                echo "$filename has been renamed as $new_filename."
                return
                ;;
            3)
                chmod 666 "$filename"
                echo "Permissions have been updated."
                ls -l "$filename"
                return
                ;;
            4)
                chmod 664 "$filename"
                echo "Permissions have been updated."
                ls -l "$filename"
                return
                ;;
            *)
                echo "Invalid input!"
                ;;
        esac
    done
}

while true; do
    print_menu
    read -p "> " option

    case $option in
        0)
            echo "Farewell!"
            break
            ;;
        1)
            echo "Operating System: $(uname -s)"
            echo "Node Name: $(uname -n)"
            ;;
        2)
            echo "User Info: $(whoami)"
            ;;
        3)
            while true; do
                list_files_and_directories
                print_file_menu
                read -p "> " file_option

                if [[ "$file_option" == "0" ]]; then
                    break
                elif [[ "$file_option" == "up" ]]; then
                    cd ..
                elif [[ -d "$file_option" ]]; then
                    cd "$file_option"
                elif [[ -f "$file_option" ]]; then
                    handle_file_operations "$file_option"
                else
                    echo "Invalid input!"
                fi
            done
            ;;
        4)
            echo "Not implemented!"
            ;;
        *)
            echo "Invalid option!"
            ;;
    esac
done
