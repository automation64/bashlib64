# Project: BashLib64

```shell linenums="0"


██████╗  █████╗ ███████╗██╗  ██╗██╗     ██╗██████╗  ██████╗ ██╗  ██╗
██╔══██╗██╔══██╗██╔════╝██║  ██║██║     ██║██╔══██╗██╔════╝ ██║  ██║
██████╔╝███████║███████╗███████║██║     ██║██████╔╝███████╗ ███████║
██╔══██╗██╔══██║╚════██║██╔══██║██║     ██║██╔══██╗██╔═══██╗╚════██║
██████╔╝██║  ██║███████║██║  ██║███████╗██║██████╔╝╚██████╔╝     ██║
╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝╚═════╝  ╚═════╝      ╚═╝


```

## Overview

BashLib64 is a **Bash** library intended to provide a simple interface to common OS management use cases:

| Module                                                             | Purpose                                            |
| ------------------------------------------------------------------ | -------------------------------------------------- |
| [bl64-arc](https://serdigital64.github.io/bashlib64/bl64-arc/)     | Manage archive files                               |
| [bl64-check](https://serdigital64.github.io/bashlib64/bl64-check/) | Check for conditions and report status             |
| [bl64-core](https://serdigital64.github.io/bashlib64/bl64-core/)   | Setup script run-time environment                  |
| [bl64-fmt](https://serdigital64.github.io/bashlib64/bl64-fmt/)     | Format text data                                   |
| [bl64-iam](https://serdigital64.github.io/bashlib64/bl64-iam/)     | Manage OS identity and access service              |
| [bl64-log](https://serdigital64.github.io/bashlib64/bl64-log/)     | Write messages to logs                             |
| [bl64-msg](https://serdigital64.github.io/bashlib64/bl64-msg/)     | Display messages                                   |
| [bl64-os](https://serdigital64.github.io/bashlib64/bl64-os/)       | Identify OS attributes and provide command aliases |
| [bl64-pkg](https://serdigital64.github.io/bashlib64/bl64-pkg/)     | Manage native OS packages                          |
| [bl64-sudo](https://serdigital64.github.io/bashlib64/bl64-sudo/)   | Manage sudo configuration                          |
| [bl64-vcs](https://serdigital64.github.io/bashlib64/bl64-vcs/)     | Manage Version Control System                      |

The library is designed to create a predictable and secure execution environment for scripts:

- Initializes the script for secure execution.
- Provides exported constants with full paths to OS commands.
- Provides wrapper functions to common OS commands.

## Deployment

### OS Compatibility

The library has been tested on the following operating systems:

- CentOS8
- OracleLinux8
- Ubuntu20
- Ubuntu21
- Fedora33
- Fedora35
- Debian10
- Debian11
- Alpine3

### Prerequisites

- Minimum Bash version: 5

### Installation

#### Add library to existing script

- Download the library to the project directory

  ```shell
  cd <PROJECT_DIR>
  wget https://raw.githubusercontent.com/serdigital64/bashlib64/main/bashlib64.bash
  ```

- Add the library loader to the target script:

  ```shell
  source "<PROJECT_DIR>/bashlib64.bash"
  ```

#### Create new script

- Download library to the project directory

  ```shell
  cd <PROJECT_DIR>
  wget https://raw.githubusercontent.com/serdigital64/bashlib64/main/bashlib64.bash
  ```

- Download skeleton script:

  ```shell
  wget https://raw.githubusercontent.com/serdigital64/bashlib64/main/skel/generic
  ```

- Customize the script by adding new content and replacing predefined tags:

| Tag                   | Purpose                                |
| --------------------- | -------------------------------------- |
| `X_AUTHOR_ALIAS_X`    | Author alias, short-name, or AKA       |
| `X_AUTHOR_GIT_URL_X`  | Author's GIT repo                      |
| `X_APP_INFO_X`        | Program, script, app short description |
| `X_APP_VERSION_X`     | Code version                           |
| `X_APP_NAMESPACE_X`   | Script namespace                       |
| `X_PROJECT_GIT_URL_X` | Project GIT Repo URL                   |

## Development

### Repositories

- Project GIT repository: [https://github.com/serdigital64/bashlib64](https://github.com/serdigital64/bashlib64)
- Project Documentation: [https://serdigital64.github.io/bashlib64/](https://serdigital64.github.io/bashlib64/)

### Contributing

Help on implementing new features and maintaining the code base is welcomed.

[Contributor Covenant Code of Conduct](https://serdigital64.github.io/bashlib64/cod/)

### License

[GPL-3.0-or-later](https://www.gnu.org/licenses/gpl-3.0.txt)

### Author

- [SerDigital64](https://github.com/serdigital64)
