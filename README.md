# Project: BashLib64

![License](https://img.shields.io/github/license/automation64/bashlib64)
![GitHub stars](https://img.shields.io/github/stars/automation64/bashlib64?style=social)
![GitHub forks](https://img.shields.io/github/forks/automation64/bashlib64?style=social)
![Release Downloads](https://img.shields.io/github/downloads/automation64/bashlib64/total)

```shell linenums="0"


██████╗  █████╗ ███████╗██╗  ██╗██╗     ██╗██████╗  ██████╗ ██╗  ██╗
██╔══██╗██╔══██╗██╔════╝██║  ██║██║     ██║██╔══██╗██╔════╝ ██║  ██║
██████╔╝███████║███████╗███████║██║     ██║██████╔╝███████╗ ███████║
██╔══██╗██╔══██║╚════██║██╔══██║██║     ██║██╔══██╗██╔═══██╗╚════██║
██████╔╝██║  ██║███████║██║  ██║███████╗██║██████╔╝╚██████╔╝     ██║
╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝╚═════╝  ╚═════╝      ╚═╝


```

- [Project: BashLib64](#project-bashlib64)
  - [📌 Overview](#-overview)
  - [📦 Deployment](#-deployment)
    - [Minimum Requirements](#minimum-requirements)
    - [Installation](#installation)
  - [🚀 Usage](#-usage)
  - [🛠 Contributing](#-contributing)
  - [⚠️ Disclaimer](#️-disclaimer)
  - [📜 License](#-license)
  - [👤 Author](#-author)

---

## 📌 Overview

BashLib64 is a **Bash** library that provides a simple abstraction layer for developing multi-platform automation scripts.

| Module                                                             | Purpose                                            |
| ------------------------------------------------------------------ | -------------------------------------------------- |
| [bl64-api](https://automation64.github.io/bashlib64/bl64-api/)     | Interact with RESTful APIs                         |
| [bl64-ans](https://automation64.github.io/bashlib64/bl64-ans/)     | Interact with Ansible                              |
| [bl64-arc](https://automation64.github.io/bashlib64/bl64-arc/)     | Manage archive files                               |
| [bl64-aws](https://automation64.github.io/bashlib64/bl64-aws/)     | Interact with Amazon AWS                           |
| [bl64-bsh](https://automation64.github.io/bashlib64/bl64-bsh/)     | Interact with Bash shell                           |
| [bl64-check](https://automation64.github.io/bashlib64/bl64-check/) | Check for conditions and report status             |
| [bl64-cnt](https://automation64.github.io/bashlib64/bl64-cnt/)     | Interact with container engines                    |
| [bl64-cryp](https://automation64.github.io/bashlib64/bl64-cryp/)   | Cryptography tools                                 |
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

---

## 📦 Deployment

### Minimum Requirements

The library has been tested on the following operating systems:

- AlmaLinux: 8,9,10
- Alpine: 3.17,3.18,3.19,3.20,3.21,3.22
- AmazonLinux: 2023
- ArchLinux, CachyOS, Manjaro: 2025
- CentOS: 7,8,9,10
- Debian: 9,10,11,12,13
- Fedora: 33,34,35,36,37,38,39,40,41,42,43
- KaliLinux: 2024,2025
- MacOS (\*): 12,13,14,15
- OracleLinux; 7,8,9,10
- RedHatEnterpriseLinux: 8,9,10
- RockyLinux: 8,9,10
- SuSELinuxEnterpriseServer: 15, 16
- Ubuntu: 18,20,21,22,23,24,25

Minimum Bash version: 4

### Installation

Download the library to the project directory

```shell
curl -O https://raw.githubusercontent.com/automation64/bashlib64/main/bashlib64.bash
  ```

Or use the **Installer64** tool to install it in `/opt/bl64`

```shell
curl -sL https://raw.githubusercontent.com/automation64/installer64/main/src/bootstrap | sh
```

Or download the distributable package from GitHub releases:

- `bashlib64-stand-alone.tgz`: single library file (`bashlib64.bash`) with all modules.
- `bashlib64-split.tgz`: two library files: `bashlib64-core.bash` for main modules and `bashlib64-opt.bash` for remaining ones.
- `bashlib64-modular.tgz`: one file per module (`bashlib64-module-*.bash`)

---

## 🚀 Usage

- Add the library loader to the target script:

```shell
source "<LIBRARY_LOCATION>/bashlib64.bash"
```

---

## 🛠 Contributing

Contributions are welcome! Help us improve by submitting issues, feature requests, or pull requests.

- [Code of Conduct](https://github.com/automation64/bashlib64/blob/main/CODE_OF_CONDUCT.md)

## ⚠️ Disclaimer

This repository is provided "as is" without any warranties. The author is not responsible for any damages or issues arising from its use. Additionally, this project is not affiliated with or endorsed by any organization or entity. Use at your own risk.

---

## 📜 License

[Apache-2.0](https://www.apache.org/licenses/LICENSE-2.0.txt)

---

## 👤 Author

- [SerDigital64](https://github.com/serdigital64)

---

🌟 **If you find this project useful, consider giving it a star!** ⭐
