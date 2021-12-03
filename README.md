# Project: Shell64

```shell
  █████████  █████               ████  ████   ████████  █████ █████ 
 ███░░░░░███░░███               ░░███ ░░███  ███░░░░███░░███ ░░███  
░███    ░░░  ░███████    ██████  ░███  ░███ ░███   ░░░  ░███  ░███ █
░░█████████  ░███░░███  ███░░███ ░███  ░███ ░█████████  ░███████████
 ░░░░░░░░███ ░███ ░███ ░███████  ░███  ░███ ░███░░░░███ ░░░░░░░███░█
 ███    ░███ ░███ ░███ ░███░░░   ░███  ░███ ░███   ░███       ░███░ 
░░█████████  ████ █████░░██████  █████ █████░░████████        █████ 
 ░░░░░░░░░  ░░░░ ░░░░░  ░░░░░░  ░░░░░ ░░░░░  ░░░░░░░░        ░░░░░  
```

## Overview

Shell64 is a project for creating bash libraries that can facilitate and accelerate the development of Bash scripts.

| Library                     | Purpose                                                   |
| --------------------------- | --------------------------------------------------------- |
| `src/bash/shell64.bash`     | Prepare the execution environment, load shell64 libraries |
| `src/bash/shell64_os.bash`  | Detect the OS, normalize common OS commands               |
| `src/bash/shell64_msg.bash` | Show messages to the user                                 |
| `src/bash/shell64_log.bash` | Write messages to logs repositories                       |

## Deployment

### OS Compatibility

The library has been tested in the following operating systems:

- CentOS8
- OracleLinux8
- Ubuntu20
- Ubuntu21
- Fedora33
- Debian10
- Debian11

### Prerequisites

- Minimum Bash version: 5

### Installation

Download the library set to a directory where the target script can read them from.

## Usage

### Add library to existing script

Add to the target script:

- The location of the Shell64 library set:
  > `SHELL64_LIB=<PATH_TO_THE_LIB>`
- The library loader:
  > `source "$SHELL64_LIB/shell64.bash"`

### Create new sript

- Copy the shell64 library set the project directory
  > `cp src/bash/shell64*.bash <PROJECT_DIR>`
- Copy the skeletong script to the project directory
  > `cp skel/generic.sh <PROJECT_DIR>`
- Customize the script by adding new content and replacing the predefined tags:

| Tag                  | Purpose                                |
| -------------------- | -------------------------------------- |
| X_AUTHOR_ALIAS_X     | Author alias, short-name, or AKA       |
| X_AUTHOR_GIT_URL_X   | Author's GIT repo                      |
| X_CODE_PURPOSE_X     | Program, script, app short description |
| X_CODE_VERSION_X     | Code version                           |
| X_PROJECT_GIT_URL_X  | Project GIT Repo URL                   |
| X_NAMESPACE_SCRIPT_X | Script namespace                       |

### Repositories

- Project GIT repository: [https://github.com/serdigital64/shell64](https://github.com/serdigital64/shell64)

### Author

- [SerDigital64](https://github.com/serdigital64)

## License

[GPL-3.0-or-later](https://www.gnu.org/licenses/gpl-3.0.txt)
