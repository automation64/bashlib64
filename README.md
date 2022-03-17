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

BashLib64 is a **Bash** library that provides a simple abstraction layer for developing multi-platform scripts.

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
| [bl64-rnd](https://serdigital64.github.io/bashlib64/bl64-rnd/)     | Generate random data                               |
| [bl64-rxtx](https://serdigital64.github.io/bashlib64/bl64-rxtx/)   | Transfer and Receive data over the network         |
| [bl64-sudo](https://serdigital64.github.io/bashlib64/bl64-sudo/)   | Manage sudo configuration                          |
| [bl64-txt](https://serdigital64.github.io/bashlib64/bl64-txt/)     | Manipulate text files content                      |
| [bl64-vcs](https://serdigital64.github.io/bashlib64/bl64-vcs/)     | Manage Version Control System                      |
| [bl64-xsv](https://serdigital64.github.io/bashlib64/bl64-xsv/)     | Manipulate CSV like text files                     |

## Deployment

### OS Compatibility

The library has been tested on the following operating systems:

- AlmaLinux8
- Alpine3
- CentOS8
- Debian10
- Debian11
- Fedora33
- Fedora35
- OracleLinux8
- Ubuntu20
- Ubuntu21

### Prerequisites

- Minimum Bash version: 5

### Installation

- Download the library to the project directory

  ```shell
  cd <PROJECT_DIR>
  wget https://raw.githubusercontent.com/serdigital64/bashlib64/main/bashlib64.bash
  ```

- Add the library loader to the target script:

  ```shell
  source "<PROJECT_DIR>/bashlib64.bash"
  ```

## Development

### Environment

- Prepare dev tools
  - Install GIT
  - Install Podman: container based testing
  - Install ShellCheck code linting
  - Install Bats-Core: code testing
- Clone GIT repository

  ```shell
  git clone https://github.com/serdigital64/bashlib64.git
  ```

- Adjust environment variables to reflect your configuration:

  ```shell
  # Copy environment definition files from templates:
  cp dot.local .local
  cp dot.secrets .secrets
  # Review and update content for both files
  ```

- Initialize dev environment variables

  ```shell
  source bin/devbl-set
  ```

### Repositories

- Project GIT repository: [https://github.com/serdigital64/bashlib64](https://github.com/serdigital64/bashlib64)
- Project Documentation: [https://serdigital64.github.io/bashlib64/](https://serdigital64.github.io/bashlib64/)
- Release history: [CHANGELOG](CHANGELOG.md)

## Contributing

Help on implementing new features and maintaining the code base is welcomed.

[Contributor Covenant Code of Conduct](https://github.com/serdigital64/bashlib64/blob/main/CODE_OF_CONDUCT.md)

## License

[GPL-3.0-or-later](https://www.gnu.org/licenses/gpl-3.0.txt)

## Author

- [SerDigital64](https://github.com/serdigital64)
