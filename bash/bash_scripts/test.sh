#!/bin/bash

# variables
# name="World"

# # functions
# function test() {
#     echo "Hello, $name"
# }
#
# # main
# function main() {
#     test
# }

# run main
# main

# # loops
# for i in {1..5}; do
#     echo "Loop iteration: $i"
# done

# # loops with conditionals
# for (( i=1; i<=5; i++ )); do
#     if [ $i -eq 3 ]; then
#         echo "Skipping iteration 3"
#         continue  # Skip the rest of the loop for this iteration
#     fi
#     echo "Loop iteration: $i"
# done

# # conditionals
# if [ "$name" == "test" ]; then
#    echo "Name is test"
#    else
#    echo "Name is not test"
#    fi

# # arrays
# my_array=("one" "two" "three")
# for item in "${my_array[@]}"; do
#   echo "Array item: $item"
#   done

# # # functions with parameters
# function greet() {
#     local person="$1"
#     echo "Hello, $person"
# }
# # main function to call greet
# function main() {
#     greet "$name"
# }
#
# # run main
# main # prints "Hello, World"

# # string manipulation
# function string_manipulation() {
#     local str="Hello, World"
#     echo "Original string: $str"
#
#     # Convert to uppercase
#     local upper_str=${str^^}
#     echo "Uppercase: $upper_str"
#
#     # Convert to lowercase
#     local lower_str=${str,,}
#     echo "Lowercase: $lower_str"
#
#     # Length of the string
#     local length=${#str}
#     echo "Length: $length"
#
#     # Substring
#     local substring=${str:7:5}  # :start index and length
#     echo "Substring (7, 5): $substring"
# }
#
# # main function to call string manipulation
# function main() {
#     string_manipulation
# }
#
# # run main
# main


# # File operations
# function file_operations() {
#     local filename="testfile.txt"
#
#     # Create a file
#     echo "Creating file: $filename"
#     echo "Hello, World" > "$filename"
#
#     # Read from the file
#     echo "Reading from file:"
#     cat "$filename"
#
#     # Append to the file
#     echo "Appending to file..."
#     echo "This is a test." >> "$filename"
#     cat "$filename"
#
#     # Delete the file
#     echo "Deleting file..."
#     rm "$filename"
# }
#
# # main function to call file operations
# function main() {
#     file_operations
# }
# # run main
# main


# # Networking operations
# function networking_operations() {
#     local url="https://www.example.com"
#
#     # Fetch content from a URL
#     echo "Fetching content from $url"
#     curl -s "$url" | head -n 10  # Display first 10 lines of the response
#
#     # Check if a URL is reachable
#     echo "Checking if $url is reachable..."
#     if curl --output /dev/null --silent --head --fail "$url"; then
#         echo "$url is reachable."
#     else
#         echo "$url is not reachable."
#     fi
# }
#
# # main function to call networking operations
# function main() {
#     networking_operations
# }
#
# # run main
# main


# # Error handling
# function error_handling() {
#     local filename="non_existent_file.txt"
#
#     # Try to read a non-existent file
#     echo "Trying to read $filename"
#     if ! cat "$filename"; then
#         echo "Error: $filename does not exist."
#     fi
#
#     # Try to create a directory that already exists
#     local dir_name="existing_directory"
#     mkdir -p "$dir_name"  # Create directory if it doesn't exist
#     echo "Trying to create directory $dir_name"
#     if ! mkdir "$dir_name"; then
#         echo "Error: Directory $dir_name already exists."
#     fi
# }
#
# # main function to call error handling
# function main() {
#     error_handling
# }
#
# main


# Debugging
# function debugging_example() {
#     local var1="Hello"
#     local var2="World"
#
#     # Set -x for debugging
#     set -x
#
#     # Example operations
#     echo "$var1, $var2!"
#
#     # Unset -x to stop debugging
#     set +x
# }
#
# # main function to call debugging example
# function main() {
#     debugging_example
# }
#
# main


# # # Input and Output Redirection
# function input_output_redirection() {
#     local input_file="input.txt"
#     local output_file="output.txt"
#
#     # Create an input file
#     echo "This is a test input file." > "$input_file"
#
#     # Redirect input from a file
#     echo "Reading from $input_file:"
#     cat < "$input_file"
#
#     # Redirect output to a file
#     echo "Writing to $output_file:"
#     echo "This is the output file." > "$output_file"
#
#     # Display the content of the output file
#     echo "Content of $output_file:"
#     cat "$output_file"
# }
#
# # main function to call input and output redirection
# function main() {
#     input_output_redirection
# }
# main


# # Signal Handling
# function signal_handling() {
#     echo "Press Ctrl+C to trigger a signal."
#
#     # Trap SIGINT (Ctrl+C) and execute a function
#     trap 'echo "Caught SIGINT! Exiting..."; exit 0' SIGINT
#
#     # Infinite loop to keep the script running
#     while true; do
#         sleep 1
#         echo "Running... (Press Ctrl+C to stop)"
#     done
# }
#
# # main function to call signal handling
# function main() {
#     signal_handling
# }
# main


# # Process Management
# function process_management() {
#     echo "Current running processes:"
#     ps aux | head -n 5  # Display first 5 processes
#
#     echo "Sleeping for 5 seconds..."
#     sleep 5 &  # Run sleep in the background
#
#     echo "Background process ID: $!"
#     echo "Waiting for background process to finish..."
#     wait $!  # Wait for the background process to finish
#
#     echo "Background process completed."
# }
#
# # main function to call process management
# function main() {
#     process_management
# }
# main


# # Command Line Arguments
# function command_line_arguments() {
#     echo "Number of arguments: $#"  # Count of arguments
#     echo "All arguments: $@"  # All arguments as a single string
#
#     if [ $# -eq 0 ]; then
#         echo "No arguments provided."
#     else
#         for arg in "$@"; do
#             echo "Argument: $arg"
#         done
#     fi
# }
#
# # main function to call command line arguments
# function main() {
#     command_line_arguments "$@"
# }
# # run main with command line arguments
# main "$@"


# # Another example of command line arguments
# function another_command_line_example() {
#     echo "Script name: $0"  # Name of the script
#     echo "Total arguments: $#"
#
#     if [ $# -lt 2 ]; then
#         echo "Please provide at least two arguments."
#         return 1
#     fi
#
#     local first_arg="$1"
#     local second_arg="$2"
#
#     echo "First argument: $first_arg"
#     echo "Second argument: $second_arg"
# }
#
# # main function to call another command line example
# function main() {
#     another_command_line_example "$@"
# }
# main "$@"

# # Using getopts for command line options
# function command_line_options() {
#     local option
#     local name=""
#
#     while getopts ":n:" option; do
#         case $option in
#             n) name="$OPTARG" ;;  # Get the value of the -n option
#             \?) echo "Invalid option: -$OPTARG" >&2 ;;
#             :) echo "Option -$OPTARG requires an argument." >&2 ;;
#         esac
#     done
#
#     if [ -z "$name" ]; then
#         echo "No name provided. Use -n <name> to specify a name."
#     else
#         echo "Hello, $name!"
#     fi
# }
#
# # main function to call command line options
# function main() {
#     command_line_options "$@"
# }
#
# main "$@"


# # Using associative arrays (Bash 4.0+)
# function associative_arrays_example() {
#     declare -A my_dict  # Declare an associative array
#
#     # Adding key-value pairs
#     my_dict["name"]="Alice"
#     my_dict["age"]=30
#     my_dict["city"]="Wonderland"
#
#     # Accessing values
#     echo "Name: ${my_dict[name]}"
#     echo "Age: ${my_dict[age]}"
#     echo "City: ${my_dict[city]}"
#
#     # Looping through keys and values
#     echo "All entries in the dictionary:"
#     for key in "${!my_dict[@]}"; do
#         echo "$key: ${my_dict[$key]}"
#     done
# }
#
# # main function to call associative arrays example
# function main() {
#     associative_arrays_example
# }
# main "$@"


# # Using a select loop for user input
# select choice in "Hello World" "Goodbye World" "Exit"
# do
#     case $choice in
#         "Hello World")
#             echo "You chose: Hello World"
#             ;;
#         "Goodbye World")
#             echo "You chose: Goodbye World"
#             ;;
#         "Exit")
#             echo "Exiting..."
#             break
#             ;;
#         *)
#             echo "Invalid choice. Please try again."
#             ;;
#     esac
# done


# # Using a case statement for pattern matching
# function case_statement_example() {
#     local input="$1"
#
#     case $input in
#         "hello")
#             echo "You said hello!"
#             ;;
#         "bye")
#             echo "You said goodbye!"
#             ;;
#         "help")
#             echo "You asked for help!"
#             ;;
#         *)
#             echo "Unknown input: $input"
#             ;;
#     esac
# }
#
# # main function to call case statement example
# function main() {
#     if [ $# -eq 0 ]; then
#         echo "Please provide an input."
#         return 1
#     fi
#
#     case_statement_example "$1"
# }
#
# # run main with command line argument
# main "$@"


# # Using a while loop for user input
# function while_loop_input() {
#     local input
#
#     echo "Enter 'exit' to quit the loop."
#     while true; do
#         read -p "Input: " input
#         if [ "$input" == "exit" ]; then
#             echo "Exiting the loop."
#             break
#         else
#             echo "You entered: $input"
#         fi
#     done
# }
#
# # main function to call while loop input
# function main() {
#     while_loop_input
# }
# main "$@"

