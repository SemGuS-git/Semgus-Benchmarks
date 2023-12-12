#!/bin/bash

# Loop over all .sl files in the current directory
for file in ../*.sl
do
  # Run semgus-parser on the file
  output=$(semgus-parser "$file" 2>&1)

  # Check if the last line of the output starts with "error: fatal error"
  last_line=$(echo "$output" | tail -n 1)
  if [[ $last_line == "error: fatal error"* ]]
  then
    # If it does, print the output to the terminal
    echo "error with file $file"
  fi
done

