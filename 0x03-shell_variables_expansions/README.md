# 0x03. Shell, init files, variables and expansions

This directory contains shell scripts that demonstrate various shell concepts including aliases, variables, and path manipulation.

## Files Description

### 0-alias

Creates an alias that maps the `ls` command to `rm *`.

- **Usage**: `source ./0-alias`
- **Effect**: After sourcing, typing `ls` will execute `rm *` (removes all files in current directory)
- **Warning**: This is dangerous! Use `\ls` to bypass the alias and use the original ls command

### 1-hello_you

Prints a greeting message to the current Linux user.

- **Usage**: `./1-hello_you`
- **Output**: `hello [current_username]`
- **Uses**: The `$USER` environment variable to get the current username

### 2-path

Adds the directory `/action` to the end of the PATH environment variable.

- **Usage**: `source ./2-path`
- **Effect**: Appends `/action` to the PATH, making it the last directory searched for executables
- **Uses**: `export` command to modify the PATH variable

### 3-paths

Counts and displays the number of directories in the PATH environment variable.

- **Usage**: `source ./3-paths` or `. ./3-paths`
- **Output**: Number of directories in PATH
- **Method**: Uses `tr` to replace colons with newlines and `wc -l` to count lines

## Requirements Met

- All scripts are exactly 2 lines long
- All scripts start with `#!/bin/bash`
- All scripts end with a newline
- All files are executable
- No use of `&&`, `||`, `;`, `bc`, `sed`, or `awk`

## Testing Environment

These scripts are designed to work on Ubuntu 20.04 LTS.
