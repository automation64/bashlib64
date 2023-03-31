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

BashLib64 is a **Bash** automation library that provides a simple abstraction layer for developing multi-platform scripts.

| Module                                                             | Purpose                                            |
| ------------------------------------------------------------------ | -------------------------------------------------- |
| [bl64-ans](https://serdigital64.github.io/bashlib64/bl64-ans/)     | Interact with Ansible                              |
| [bl64-arc](https://serdigital64.github.io/bashlib64/bl64-arc/)     | Manage archive files                               |
| [bl64-aws](https://serdigital64.github.io/bashlib64/bl64-aws/)     | Interact with Amazon AWS                           |
| [bl64-bsh](https://serdigital64.github.io/bashlib64/bl64-bsh/)     | Interact with Bash shell                           |
| [bl64-check](https://serdigital64.github.io/bashlib64/bl64-check/) | Check for conditions and report status             |
| [bl64-cnt](https://serdigital64.github.io/bashlib64/bl64-cnt/)     | Interact with container engines                    |
| [bl64-dbg](https://serdigital64.github.io/bashlib64/bl64-dbg/)     | Show shell debugging information                   |
| [bl64-fmt](https://serdigital64.github.io/bashlib64/bl64-fmt/)     | Format text data                                   |
| [bl64-fs](https://serdigital64.github.io/bashlib64/bl64-fs/)       | Manage local filesystem                            |
| [bl64-gcp](https://serdigital64.github.io/bashlib64/bl64-gcp/)     | Interact with Google Cloud                         |
| [bl64-hlm](https://serdigital64.github.io/bashlib64/bl64-hlm/)     | Interact with Helm                                 |
| [bl64-iam](https://serdigital64.github.io/bashlib64/bl64-iam/)     | Manage OS identity and access service              |
| [bl64-k8s](https://serdigital64.github.io/bashlib64/bl64-k8s/)     | Interact with Kubernetes                           |
| [bl64-lib](https://serdigital64.github.io/bashlib64/bl64-lib/)     | Setup script run-time environment                  |
| [bl64-log](https://serdigital64.github.io/bashlib64/bl64-log/)     | Write messages to logs                             |
| [bl64-mdb](https://serdigital64.github.io/bashlib64/bl64-mdb/)     | Interact with MongoDB                              |
| [bl64-msg](https://serdigital64.github.io/bashlib64/bl64-msg/)     | Display messages                                   |
| [bl64-os](https://serdigital64.github.io/bashlib64/bl64-os/)       | Identify OS attributes and provide command aliases |
| [bl64-pkg](https://serdigital64.github.io/bashlib64/bl64-pkg/)     | Manage native OS packages                          |
| [bl64-py](https://serdigital64.github.io/bashlib64/bl64-py/)       | Interact with Python                               |
| [bl64-rbac](https://serdigital64.github.io/bashlib64/bl64-rbac/)   | Manage role based access service                   |
| [bl64-rnd](https://serdigital64.github.io/bashlib64/bl64-rnd/)     | Generate random data                               |
| [bl64-rxtx](https://serdigital64.github.io/bashlib64/bl64-rxtx/)   | Transfer and Receive data over the network         |
| [bl64-tf](https://serdigital64.github.io/bashlib64/bl64-tf/)       | Interact with Terraform                            |
| [bl64-time](https://serdigital64.github.io/bashlib64/bl64-time/)   | Manage date-time data                              |
| [bl64-txt](https://serdigital64.github.io/bashlib64/bl64-txt/)     | Manipulate text files content                      |
| [bl64-ui](https://serdigital64.github.io/bashlib64/bl64-ui/)       | User Interface                                     |
| [bl64-vcs](https://serdigital64.github.io/bashlib64/bl64-vcs/)     | Manage Version Control System                      |
| [bl64-xsv](https://serdigital64.github.io/bashlib64/bl64-xsv/)     | Manipulate CSV like text files                     |

## Deployment

### OS Compatibility

The library has been tested on the following operating systems:

- AlmaLinux8
- AlmaLinux9
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
- Fedora37
- MacOS12
  - Requires Bash4 (e.g. homebrew install bash)
- OracleLinux7
- OracleLinux8
- OracleLinux9
- RedHatLinux8
- RedHatLinux9
- RockyLinux8
- RockyLinux9
- Ubuntu20
- Ubuntu21
- Ubuntu22

### Prerequisites

- Minimum Bash version: 4

### Installation

- Download the library to the project directory

  ```shell
  curl -O https://raw.githubusercontent.com/serdigital64/bashlib64/main/bashlib64.bash
  ```

- Add the library loader to the target script:

  ```shell
  source "<PROJECT_DIR>/bashlib64.bash"
  ```

- The library is also available in two smaller files:
  - [bashlib64-core](https://raw.githubusercontent.com/serdigital64/bashlib64/main/bashlib64-core.bash): core modules
  - [bashlib64-opt](https://raw.githubusercontent.com/serdigital64/bashlib64/main/bashlib64-opt.bash): optional modules

## Contributing

Help on implementing new features and maintaining the code base is welcomed.

- [Guidelines](https://github.com/serdigital64/bashlib64/blob/main/CONTRIBUTING.md)
- [Contributor Covenant Code of Conduct](https://github.com/serdigital64/bashlib64/blob/main/CODE_OF_CONDUCT.md)

## License

[Apache-2.0](https://www.apache.org/licenses/LICENSE-2.0.txt)

## Author

- [SerDigital64](https://github.com/serdigital64)
