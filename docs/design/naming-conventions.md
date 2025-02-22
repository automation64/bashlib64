# BashLib64 - Naming Conventions

- [BashLib64 - Naming Conventions](#bashlib64---naming-conventions)
  - [Function Names](#function-names)
    - [Internal](#internal)
    - [Generic Action](#generic-action)
    - [Attribute Getter / Setter](#attribute-getter--setter)
    - [Flag](#flag)
    - [Command Runner](#command-runner)
  - [Variable Names](#variable-names)
    - [Global Internal](#global-internal)
    - [Global Generic](#global-generic)

## Function Names

### Internal

- `_<FUNCTION>`

### Generic Action

- `<MODULE>[_OBJECT]_<ACTION>[_PARAMETER]`

### Attribute Getter / Setter

- `<MODULE>[_OBJECT]_get_<ATTRIBUTE>`
- `<MODULE>[_OBJECT]_set_<ATTRIBUTE>`

### Flag

- `<MODULE>[_OBJECT]_is_set_<FLAG>`
- `<MODULE>[_OBJECT]_is_enabled_<FLAG>`
- `<MODULE>[_OBJECT]_is_disabled_<FLAG>`
- `<MODULE>[_OBJECT]_enable_<FLAG>`
- `<MODULE>[_OBJECT]_disable_<FLAG>`

### Command Runner

- `<MODULE>_run_<COMMAND>`

## Variable Names

### Global Internal

- `_<VARIABLE>`

### Global Generic

- `<MODULE>[_OBJECT]_<ATTRIBUTE>`
