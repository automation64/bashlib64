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
| [bl64-ans](https://serdigital64.github.io/bashlib64/bl64-ans/)     | Interact with Ansible                              |
| [bl64-arc](https://serdigital64.github.io/bashlib64/bl64-arc/)     | Manage archive files                               |
| [bl64-check](https://serdigital64.github.io/bashlib64/bl64-check/) | Check for conditions and report status             |
| [bl64-cnt](https://serdigital64.github.io/bashlib64/bl64-cnt/)     | Interact with container engines                    |
| [bl64-dbg](https://serdigital64.github.io/bashlib64/bl64-dbg/)     | Show shell debugging information                   |
| [bl64-fmt](https://serdigital64.github.io/bashlib64/bl64-fmt/)     | Format text data                                   |
| [bl64-gcp](https://serdigital64.github.io/bashlib64/bl64-gcp/)     | Interact with Google Cloud CLI                     |
| [bl64-iam](https://serdigital64.github.io/bashlib64/bl64-iam/)     | Manage OS identity and access service              |
| [bl64-lib](https://serdigital64.github.io/bashlib64/bl64-lib/)     | Setup script run-time environment                  |
| [bl64-log](https://serdigital64.github.io/bashlib64/bl64-log/)     | Write messages to logs                             |
| [bl64-msg](https://serdigital64.github.io/bashlib64/bl64-msg/)     | Display messages                                   |
| [bl64-os](https://serdigital64.github.io/bashlib64/bl64-os/)       | Identify OS attributes and provide command aliases |
| [bl64-pkg](https://serdigital64.github.io/bashlib64/bl64-pkg/)     | Manage native OS packages                          |
| [bl64-py](https://serdigital64.github.io/bashlib64/bl64-py/)       | Interact with system-wide Python                   |
| [bl64-rbac](https://serdigital64.github.io/bashlib64/bl64-rbac/)   | Manage role based access service                   |
| [bl64-rnd](https://serdigital64.github.io/bashlib64/bl64-rnd/)     | Generate random data                               |
| [bl64-rxtx](https://serdigital64.github.io/bashlib64/bl64-rxtx/)   | Transfer and Receive data over the network         |
| [bl64-txt](https://serdigital64.github.io/bashlib64/bl64-txt/)     | Manipulate text files content                      |
| [bl64-vcs](https://serdigital64.github.io/bashlib64/bl64-vcs/)     | Manage Version Control System                      |
| [bl64-xsv](https://serdigital64.github.io/bashlib64/bl64-xsv/)     | Manipulate CSV like text files                     |

## Deployment

### OS Compatibility

The library has been tested on the following operating systems:

- AlmaLinux8
- Alpine3
- CentOS7
- CentOS8
- CentOS9
- Debian9
- Debian10
- Debian11
- Fedora33
- Fedora34
- Fedora35
- MacOS12
  - Requires Bash4 (e.g. homebrew install bash)
- OracleLinux7
- OracleLinux8
- RedHatLinux8
- RockyLinux8
- Ubuntu20
- Ubuntu21
- Ubuntu22

### Prerequisites

- Minimum Bash version: 4

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

## Contributing

Help on implementing new features and maintaining the code base is welcomed.

- [Guidelines](https://github.com/serdigital64/bashlib64/blob/main/CONTRIBUTING.md)
- [Contributor Covenant Code of Conduct](https://github.com/serdigital64/bashlib64/blob/main/CODE_OF_CONDUCT.md)

## License

[GPL-3.0-or-later](https://www.gnu.org/licenses/gpl-3.0.txt)

## Author

- [SerDigital64](https://github.com/serdigital64)
