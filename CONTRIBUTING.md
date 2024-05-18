# Contributing

## Prepare Development Environment

- Prepare dev tools
  - Install GIT
- Clone GIT repository

  ```shell
  git clone https://github.com/automation64/bashlib64.git
  ```

- Adjust environment variables to match your configuration:
  - Copy environment definition files from templates:

  ```shell
  cp dot.local .local
  cp dot.secrets .secrets
  ```

  - Review and update content for both files

- Download dev support scripts

  ```shell
  ./bin/dev-lib-base
  ```

## Update source code

- Add/Edit source code in: `src/`

## Batch test source code locally

- Add/update test-cases in: `test/batscore`
- Build for testing:

  ```shell
  ./bin/dev-build-project -t
  ```

- Run test-cases using container images bundled with the `testmansh` tool

  ```shell
  ./bin/dev-test-testmansh [CONTAINER] [TEST_CASE]
  # example:
  ./bin/dev-test-testmansh bash-test/sles-15-bash-test test/batscore/bash-os/iam/bl64_iam_user_add_08 
  ```

## Test source code in live container

- Open a lab (sandbox) container

  ```shell
  ./bin/dev-lab-bash [CONTAINER]
  ```

- Run ad-hoc tests

  ```shell
  ./test/bash/ad-hoc
  ```

## Repositories

- Project GIT repository: [https://github.com/automation64/bashlib64](https://github.com/automation64/bashlib64)
- Project Documentation: [https://serdigital64.github.io/bashlib64/](https://serdigital64.github.io/bashlib64/)
- Release history: [CHANGELOG](CHANGELOG.md)
