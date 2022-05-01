# Contributing

## Development

### Environment

- Prepare dev tools
  - Install GIT
  - Install [TestManSH](https://github.com/serdigital64/testmansh): for testing and linting
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

## Testing

## Repositories

- Project GIT repository: [https://github.com/serdigital64/bashlib64](https://github.com/serdigital64/bashlib64)
- Project Documentation: [https://serdigital64.github.io/bashlib64/](https://serdigital64.github.io/bashlib64/)
- Release history: [CHANGELOG](CHANGELOG.md)
