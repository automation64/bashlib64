# Project: BashLib64

```shell


██████╗  █████╗ ███████╗██╗  ██╗██╗     ██╗██████╗  ██████╗ ██╗  ██╗
██╔══██╗██╔══██╗██╔════╝██║  ██║██║     ██║██╔══██╗██╔════╝ ██║  ██║
██████╔╝███████║███████╗███████║██║     ██║██████╔╝███████╗ ███████║
██╔══██╗██╔══██║╚════██║██╔══██║██║     ██║██╔══██╗██╔═══██╗╚════██║
██████╔╝██║  ██║███████║██║  ██║███████╗██║██████╔╝╚██████╔╝     ██║
╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝╚═════╝  ╚═════╝      ╚═╝


```

## Overview

BashLib64 is a project for creating bash libraries that can facilitate and accelerate the development of Bash scripts.

The library is bundled as a stand-alone file that can easly be distributed along with your scripts.

Source modules included in the library:

| File                    | Purpose                                |
| ----------------------- | -------------------------------------- |
| `src/bashlib64-core.*`  | Setup run-time environment             |
| `src/bashlib64-check.*` | Check for conditions and report status |
| `src/bashlib64-check.*` | Format data                            |
| `src/bashlib64-log.*`   | Write messages to logs repositories    |
| `src/bashlib64-msg.*`   | Display messages                       |
| `src/bashlib64-pkg.*`   | Install native OS packages             |
| `src/bashlib64-os.*`    | Identify OS attributes                 |

## Deployment

## OS Compatibility

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

Download the library set to a directory where the target script can read them from:

- [BashLib64](https://raw.githubusercontent.com/serdigital64/bashlib64/main/bashlib64.bash)

## Usage

### Add library to existing script

- Download the library to the project directory
  > `cd <PROJECT_DIR>; wget https://raw.githubusercontent.com/serdigital64/bashlib64/main/bashlib64.bash`
- Add the library loader to the target script:
  > `source "<PROJECT_DIR>/bashlib64.bash"`

### Create new script

- Download the library to the project directory
  > `cd <PROJECT_DIR>; wget https://raw.githubusercontent.com/serdigital64/bashlib64/main/bashlib64.bash`
- Download the skeleton script:
  > `wget https://raw.githubusercontent.com/serdigital64/bashlib64/main/skel/generic`
- Customize the script by adding new content and replacing the predefined tags:

| Tag                 | Purpose                                |
| ------------------- | -------------------------------------- |
| X_AUTHOR_ALIAS_X    | Author alias, short-name, or AKA       |
| X_AUTHOR_GIT_URL_X  | Author's GIT repo                      |
| X_APP_INFO_X        | Program, script, app short description |
| X_APP_VERSION_X     | Code version                           |
| X_APP_NAMESPACE_X   | Script namespace                       |
| X_PROJECT_GIT_URL_X | Project GIT Repo URL                   |

### Repositories

- Project GIT repository: [https://github.com/serdigital64/bashlib64](https://github.com/serdigital64/bashlib64)

### Author

- [SerDigital64](https://github.com/serdigital64)

## License

[GPL-3.0-or-later](https://www.gnu.org/licenses/gpl-3.0.txt)
