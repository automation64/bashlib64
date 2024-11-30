# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.39.1]

### Fixed

- Helm
  - Wrong helm file permissions
- Zoxide
  - Wrong package name

### Added

- Installers
  - Syft
  - Lynis

### Changed

- Perl
  - Added Kali
- Python
  - Added Kali
- Krew
  - Changed to multiplatform
- OhMyZsh
  - Changed to multiplatform

## [3.38.0]

### Changed

- Multiple installers: removed OS compatibility list, as it's redundant with BL64

## [3.37.0]

### Added

- Installers
  - Ruff
  - Semgrep
  - Bandit
  - Zellij
  - SQLMap
  - TestSSL
  - Capa
  - gRPCurl
  - Perl
  - Nikto
- Helm
  - Multi OS support

### Fixed

- PGAdmin
  - Fixed function wrong name

### Added

- Installers
  - Ray
- ArgoCD
  - Multi OS support
- Kind
  - Multi OS support

### Fixed

- PGAdmin
  - PIPX: Using PIP 24.0 to avoid PIP 24.2 issues

## [3.35.0]

### Added

- LazyDocker
  - Full bl64 compatible Linux flavors

### Changed

- MKDocs
  - Separated main package from plugins

## [3.34.0]

### Added

- MKDocs
  - Fedora support

### Fixed

- MKDocs
  - Alpine installer

## [3.33.0]

### Added

- Installer
  - delta
  - ctop
  - hwatch

### Fixed

- HTTPie
  - Change default version to 3.2.2 to avoid missing asset on source repo
- MKDocs
  - Refactor to install instead of deploy pip modules to avoid installing buggy setup-tools module (72.x)

## [3.32.2]

### Added

- Installer
  - OpenTofu

## [3.31.0]

### Added

- Installer
  - DevBin64

### Fixed

- FZF
  - Updated package name

## [3.30.0]

### Added

- Installer
  - SysDen64

## [3.29.0]

### Added

- Installer
  - SysOp64

## [3.28.0]

### Changed

- Update OS list
  - Ansible
  - AnsibleLint
  - AWSShell
  - Python
  - PreCommit

## [3.27.0]

### Added

- Installer
  - PIPX
  - LazyGit
  - PGCLI
  - LocalStack
  - PGAdmin

### Changed

- GCC
  - Update OS list: OEL, FD

### Removed

- Python
  - PIPX is no longer installed in UB. A separate installer was created to install as pip module: install-pipx

## [3.26.0]

### Changed

- Python
  - Update OS list

## [3.25.0]

### Added

- Installer
  - KubeNT
  - Exoscale CLI

### Changed

- Krew
  - Added .env file to .local/bin for PATH and app variables
- Ruby
  - Added .env.d support

### Fixed

- GitUI
  - Update platform ID

## [3.24.0]

### Added

- Installer
  - EKSCTL

### Changed

- Updated OS compatibility
  - AWS Shell
  - BashIt
  - Gitleaks
  - Hashicorp Packer
  - K9S
  - NeoVIM
  - OhMyZSH
  - KubeCTL
  - Packer
  - Starship
  - Terragrunt
  - Trufflehog
  - Zoho Vault

## [3.23.0]

### Added

- Installer
  - Terragrunt
  - NeoVIM
  - BashIt
  - OhMyZSH
  - Zoho Vault
  - Gitleaks
  - Trufflehog
  - AWS Shell
  - Hashicorp Packer

## [3.22.1]

### Added

- Installer
  - Starship

### Changed

- NodeJS
  - Updated OS compatibility list
- HadoLint
  - Updated OS compatibility list
- Kubeconform
  - Updated OS compatibility list
- Trivy
  - Updated OS compatibility list

## [3.21.0]

### Changed

- KubeScape
  - Updated OS compatibility list
- KubeLinter
  - Updated OS compatibility list
- ArgoCD CLI
  - Updated OS compatibility list

### Removed

- ArgoCD installer

## [3.20.0]

### Changed

- YAMLLint
  - Updated OS compatibility list

## [3.19.0]

### Added

- Installer
  - TaskFile
  - Dagger

## [3.18.0]

### Changed

- YQ
  - Updated OS compatibility list
- Batscore
  - Updated OS compatibility list

## [3.17.0]

### Added

- Installer
  - FD
  - Zoxide

### Changed

- TFSec
  - Updated OS compatibility list
- TFLint
  - Updated OS compatibility list
- LNav
  - Updated OS compatibility list

## [3.16.0]

### Changed

- Terraform
  - Updated OS compatibility list

## [3.15.0]

### Added

- Installer
  - Bat

### Changed

- AWS CLI
  - Published aws_complete to searchable path

## [3.14.0]

### Added

- Installer
  - Gomplate
  - FZF
  - HTTPie
  - EZA
  - DUF
  - GPing

### Changed

- KubeConform
  - Updated OS compatibility
- KubeLinter
  - Updated OS compatibility
- ShellCheck
  - Updated OS compatibility

## [3.13.0]

### Added

- Installer
  - Docker

### Changed

- GitHub CLI
  - Updated OS compatibility list

## [3.12.0]

### Fixed

- MySQL CLI
  - Replaced deprecated repo key

### Changed

- Go
  - Updated OS compatibility list

### Added

- Installer64
  - added BashLib64 installation

## [3.11.0]

### Added

- Installer:
  - Act
- Cosign
  - System Wide parameter

## [3.10.0]

### Changed

- Added OS version compatibility mode to allow non-tested OS versions (same distro)
  - install-ansible
  - install-ansiblelint
  - install-argocd
  - install-argocdcli
  - install-awscli
  - install-batscore
  - install-cosign
  - install-crane
  - install-dockle
  - install-fluxcdcli
  - install-gcc
  - install-gitui
  - install-go
  - install-hadolint
  - install-helm
  - install-helm-chart-releaser
  - install-helm-chart-tester
  - install-hugo
  - install-istioctl
  - install-jekyll
  - install-jenkinsxcli
  - install-k9s
  - install-kind
  - install-krew
  - install-ksniff
  - install-kubeconform
  - install-kubectl
  - install-kubelinter
  - install-kubepug
  - install-kubescape
  - install-kubeseal
  - install-lazydocker
  - install-lnav
  - install-minikube
  - install-mkdocs
  - install-nodejs
  - install-pluto
  - install-podman
  - install-popeye
  - install-precommit
  - install-python
  - install-ruby
  - install-shellcheck
  - install-shfmt
  - install-stern
  - install-tflint
  - install-tfsec
  - install-yamllint
  - install-yq

### Fixed

- Installer64
  - Post-install error when providing relative path for target directory
  - Package download error when current directory is read-only: now use temporary writable location
- Bashlib64
  - Post-install error when providing relative path for target directory
  - Package download error when current directory is read-only: now use temporary writable location
