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

### 4-global_variables

Lists all environment variables.

- **Usage**: `source ./4-global_variables`
- **Output**: All environment variables in the format `VARIABLE=value`
- **Uses**: `printenv` command to display environment variables

### 5-local_variables

Lists all local variables, environment variables, and functions.

- **Usage**: `source ./5-local_variables` or `. ./5-local_variables`
- **Output**: Complete list of all shell variables, environment variables, and function definitions
- **Uses**: `set` command to display all variables and functions

### 6-create_local_variable

Creates a new local variable named BEST with the value "School".

- **Usage**: `source ./6-create_local_variable`
- **Effect**: Creates a local variable that is only available in the current shell
- **Variable**: `BEST="School"`

### 7-create_global_variable

Creates a new global (environment) variable named BEST with the value "School".

- **Usage**: `source ./7-create_global_variable`
- **Effect**: Creates a global variable that will be available to child processes
- **Uses**: `export` command to make the variable available globally

### 8-true_knowledge

Prints the result of adding 128 to the value stored in the TRUEKNOWLEDGE environment variable.

- **Usage**: `./8-true_knowledge`
- **Prerequisites**: TRUEKNOWLEDGE environment variable must be set
- **Output**: Result of `128 + TRUEKNOWLEDGE`
- **Uses**: Shell arithmetic expansion `$((128 + TRUEKNOWLEDGE))`

### 9-divide_and_rule

Prints the result of dividing POWER by DIVIDE.

- **Usage**: `./9-divide_and_rule`
- **Prerequisites**: POWER and DIVIDE environment variables must be set
- **Output**: Result of `POWER / DIVIDE`
- **Uses**: Shell arithmetic expansion `$((POWER / DIVIDE))`

### 10-love_exponent_breath

Displays the result of BREATH raised to the power of LOVE.

- **Usage**: `./10-love_exponent_breath`
- **Prerequisites**: BREATH and LOVE environment variables must be set
- **Output**: Result of `BREATH ^ LOVE`
- **Uses**: Shell arithmetic expansion with exponentiation `$((BREATH ** LOVE))`

### 11-binary_to_decimal

Converts a binary number to decimal.

- **Usage**: `./11-binary_to_decimal`
- **Prerequisites**: BINARY environment variable must be set with a binary number
- **Output**: Decimal equivalent of the binary number
- **Uses**: Shell arithmetic with base conversion `$((2#$BINARY))`

### 12-combinations

Prints all possible combinations of two lowercase letters, except 'oo'.

- **Usage**: `./12-combinations`
- **Output**: 675 combinations (26² - 1), alpha ordered, one per line
- **Method**: Brace expansion `{a..z}{a..z}` with `grep -v oo` to exclude 'oo'
- **Constraint**: Script contains maximum 64 characters

### 13-print_float

Prints a number with exactly two decimal places.

- **Usage**: `./13-print_float`
- **Prerequisites**: NUM environment variable must be set
- **Output**: Number formatted to 2 decimal places
- **Uses**: `printf "%.2f\n"` for precise decimal formatting

## Advanced Tasks

### 100-decimal_to_hexadecimal

Converts a decimal number to hexadecimal.

- **Usage**: `./100-decimal_to_hexadecimal`
- **Prerequisites**: DECIMAL environment variable must be set
- **Output**: Hexadecimal representation (lowercase)
- **Uses**: `printf "%x\n"` for hexadecimal conversion

### 101-rot13

Encodes and decodes text using ROT13 encryption.

- **Usage**: `./101-rot13 < file` or `echo "text" | ./101-rot13`
- **Input**: Text from stdin
- **Output**: ROT13 encoded/decoded text
- **Method**: `tr 'A-Za-z' 'N-ZA-Mn-za-m'` (shifts each letter by 13 positions)
- **Note**: ROT13 is symmetric - applying it twice returns original text

### 102-odd

Prints every other line from input, starting with the first line.

- **Usage**: `ls -1 | ./102-odd` or `./102-odd < file`
- **Input**: Text from stdin
- **Output**: Lines 1, 3, 5, 7, etc.
- **Method**: `paste - -` pairs lines, `cut -f1` takes first column

### 103-water_and_stir

Adds two numbers in custom bases and outputs result in another custom base.

- **Usage**: `./103-water_and_stir`
- **Prerequisites**: WATER and STIR environment variables must be set
- **Input bases**:
  - WATER uses base "water" (w=0, a=1, t=2, e=3, r=4)
  - STIR uses base "stir." (s=0, t=1, i=2, r=3, .=4)
- **Output base**: "bestchol" (b=0, e=1, s=2, t=3, c=4, h=5, o=6, l=7)
- **Process**: Converts to decimal, adds, converts to octal, maps to bestchol

## Requirements Met

- All scripts are exactly 2 lines long
- All scripts start with `#!/bin/bash`
- All scripts end with a newline
- All files are executable
- No use of `&&`, `||`, `;`, `bc`, `sed`, or `awk`

## Testing Environment

These scripts are designed to work on Ubuntu 20.04 LTS.
