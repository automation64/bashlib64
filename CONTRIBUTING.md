# Contributing

## Prepare Development Environment

- Prepare dev tools
  - Install GIT
  - Install Git-Flow
- Clone GIT repository

  ```shell
  git clone https://github.com/serdigital64/bashlib64.git
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
  ./bin/devbl-lib
  ```

- Initialize git-flow. Leave defaults options

  ```shell
  git flow init
  ```

## Update source code

- Add/Edit source code in: `src/`

## Build library

- Build production library and refresh docs:

```shell
 ./bin/devbl-build -p
 ./bin/devbl-build -d
```

## Test source code

- Add/update test-cases in: `test/batscore`
- Build testing library:

```shell
 ./bin/devbl-build -t
```

- Run test-cases using container images bundled with the `testmansh` tool

```shell
./lib/testmansh -b -o
```

## Repositories

- Project GIT repository: [https://github.com/serdigital64/bashlib64](https://github.com/serdigital64/bashlib64)
- Project Documentation: [https://serdigital64.github.io/bashlib64/](https://serdigital64.github.io/bashlib64/)
- Release history: [CHANGELOG](CHANGELOG.md)
