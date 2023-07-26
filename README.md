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

BashLib64 is a **Bash** library that provides a simple abstraction layer for developing multi-platform automation scripts.

| Module                                                             | Purpose                                            |
| ------------------------------------------------------------------ | -------------------------------------------------- |
| [bl64-ans](https://automation64.github.io/bashlib64/bl64-ans/)     | Interact with Ansible                              |
| [bl64-arc](https://automation64.github.io/bashlib64/bl64-arc/)     | Manage archive files                               |
| [bl64-aws](https://automation64.github.io/bashlib64/bl64-aws/)     | Interact with Amazon AWS                           |
| [bl64-bsh](https://automation64.github.io/bashlib64/bl64-bsh/)     | Interact with Bash shell                           |
| [bl64-check](https://automation64.github.io/bashlib64/bl64-check/) | Check for conditions and report status             |
| [bl64-cnt](https://automation64.github.io/bashlib64/bl64-cnt/)     | Interact with container engines                    |
| [bl64-dbg](https://automation64.github.io/bashlib64/bl64-dbg/)     | Show shell debugging information                   |
| [bl64-fmt](https://automation64.github.io/bashlib64/bl64-fmt/)     | Format text data                                   |
| [bl64-fs](https://automation64.github.io/bashlib64/bl64-fs/)       | Manage local filesystem                            |
| [bl64-gcp](https://automation64.github.io/bashlib64/bl64-gcp/)     | Interact with Google Cloud                         |
| [bl64-hlm](https://automation64.github.io/bashlib64/bl64-hlm/)     | Interact with Helm                                 |
| [bl64-iam](https://automation64.github.io/bashlib64/bl64-iam/)     | Manage OS identity and access service              |
| [bl64-k8s](https://automation64.github.io/bashlib64/bl64-k8s/)     | Interact with Kubernetes                           |
| [bl64-lib](https://automation64.github.io/bashlib64/bl64-lib/)     | Setup script run-time environment                  |
| [bl64-log](https://automation64.github.io/bashlib64/bl64-log/)     | Write messages to logs                             |
| [bl64-mdb](https://automation64.github.io/bashlib64/bl64-mdb/)     | Interact with MongoDB                              |
| [bl64-msg](https://automation64.github.io/bashlib64/bl64-msg/)     | Display messages                                   |
| [bl64-os](https://automation64.github.io/bashlib64/bl64-os/)       | Identify OS attributes and provide command aliases |
| [bl64-pkg](https://automation64.github.io/bashlib64/bl64-pkg/)     | Manage native OS packages                          |
| [bl64-py](https://automation64.github.io/bashlib64/bl64-py/)       | Interact with Python                               |
| [bl64-rbac](https://automation64.github.io/bashlib64/bl64-rbac/)   | Manage role based access service                   |
| [bl64-rnd](https://automation64.github.io/bashlib64/bl64-rnd/)     | Generate random data                               |
| [bl64-rxtx](https://automation64.github.io/bashlib64/bl64-rxtx/)   | Transfer and Receive data over the network         |
| [bl64-tf](https://automation64.github.io/bashlib64/bl64-tf/)       | Interact with Terraform                            |
| [bl64-time](https://automation64.github.io/bashlib64/bl64-time/)   | Manage date-time data                              |
| [bl64-txt](https://automation64.github.io/bashlib64/bl64-txt/)     | Manipulate text files content                      |
| [bl64-ui](https://automation64.github.io/bashlib64/bl64-ui/)       | User Interface                                     |
| [bl64-vcs](https://automation64.github.io/bashlib64/bl64-vcs/)     | Manage Version Control System                      |
| [bl64-xsv](https://automation64.github.io/bashlib64/bl64-xsv/)     | Manipulate CSV like text files                     |

## Deployment

### OS Compatibility

The library has been tested on the following operating systems:

- AlmaLinux: 8,9
- Alpine: 3
- CentOS: 7,8,9
- Debian: 9,10,11
- Fedora: 33,34,35,36,37,38
- MacOS (*): 12,13
- OracleLinux; 7,8,9
- RedHatEnterpriseLinux: 8,9
- RockyLinux: 8,9
- SuSELinuxEnterpriseServer: 15
- Ubuntu: 18,20,21,22,23

(*) Requires Bash4 (e.g. homebrew install bash)

### Prerequisites

- Minimum Bash version: 4

### Installation

- Download the library to the project directory

  ```shell
  curl -O https://raw.githubusercontent.com/automation64/bashlib64/main/bashlib64.bash
  ```

- Add the library loader to the target script:

  ```shell
  source "<PROJECT_DIR>/bashlib64.bash"
  ```

- The library is also available in two smaller files:
  - [bashlib64-core](https://raw.githubusercontent.com/automation64/bashlib64/main/bashlib64-core.bash): core modules
  - [bashlib64-opt](https://raw.githubusercontent.com/automation64/bashlib64/main/bashlib64-opt.bash): optional modules

## Contributing

Help on implementing new features and maintaining the code base is welcomed.

- [Guidelines](https://github.com/automation64/bashlib64/blob/main/CONTRIBUTING.md)
- [Contributor Covenant Code of Conduct](https://github.com/automation64/bashlib64/blob/main/CODE_OF_CONDUCT.md)

## License

[Apache-2.0](https://www.apache.org/licenses/LICENSE-2.0.txt)

## Author

- [SerDigital64](https://github.com/serdigital64)
