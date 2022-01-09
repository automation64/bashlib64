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

BashLib64 is a project for creating **Bash** functions that can facilitate and accelerate the development of Bash scripts and code snippets such as the ones used to create container images.

## Deployment

### OS Compatibility

The library has been tested on the following operating systems:

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

#### Add library to existing script

- Download the library to the project directory
  > `#!shell cd <PROJECT_DIR>; wget https://raw.githubusercontent.com/serdigital64/bashlib64/main/bashlib64.bash`
- Add the library loader to the target script:
  > `#!shell source "<PROJECT_DIR>/bashlib64.bash"`

#### Create new script

- Download the library to the project directory
  > `#!shell cd <PROJECT_DIR>; wget https://raw.githubusercontent.com/serdigital64/bashlib64/main/bashlib64.bash`
- Download the skeleton script:
  > `#!shell wget https://raw.githubusercontent.com/serdigital64/bashlib64/main/skel/generic`
- Customize the script by adding new content and replacing the predefined tags:

| Tag                   | Purpose                                |
| --------------------- | -------------------------------------- |
| `X_AUTHOR_ALIAS_X`    | Author alias, short-name, or AKA       |
| `X_AUTHOR_GIT_URL_X`  | Author's GIT repo                      |
| `X_APP_INFO_X`        | Program, script, app short description |
| `X_APP_VERSION_X`     | Code version                           |
| `X_APP_NAMESPACE_X`   | Script namespace                       |
| `X_PROJECT_GIT_URL_X` | Project GIT Repo URL                   |

## Development

### Repository

- Project GIT repository: [https://github.com/serdigital64/bashlib64](https://github.com/serdigital64/bashlib64)

### Contributing

Help on implementing new features and maintaining the code base is welcomed.

Please see the [guidelines](cod) for further details.

### License

[GPL-3.0-or-later](https://www.gnu.org/licenses/gpl-3.0.txt)

### Author

- [SerDigital64](https://github.com/serdigital64)
