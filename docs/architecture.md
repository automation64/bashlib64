# Architecture

## Design Principles

### Predictable behavior

Implement measures to eliminate or mitigate external factors that can alter expected results of external command execution.

- Use full path to call commands even when they are provided by the operating system.
- Ignore by default exported shell variables that affects command execution.
- Identify, expose and control default configuration settings that can alter command execution.

### Code modularity

- Use modules to group features based on the technology they interact with.
- Modules at build time must separate code from data into different files:
  - `bl64-MODULE.bash`: module functions
  - `bl64-MODULE-setup.bash`: module setup
  - `bl64-MODULE-env.bash`: module wide variables
