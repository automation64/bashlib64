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

- `<MODULE>[_OBJECT]_<ATTRIBUTE>_get`
- `<MODULE>[_OBJECT]_<ATTRIBUTE>_set`

### Flag

- `<MODULE>[_OBJECT]_<FLAG>_is_set`
- `<MODULE>[_OBJECT]_<FLAG>_is_enabled`
- `<MODULE>[_OBJECT]_<FLAG>_is_disabled`
- `<MODULE>[_OBJECT]_<FLAG>_enable`
- `<MODULE>[_OBJECT]_<FLAG>_disable`

### Command Runner

- `<MODULE>_run_<COMMAND>`

## Variable Names

### Global Internal

- `_<VARIABLE>`

### Global Generic

- `<MODULE>[_OBJECT]_<ATTRIBUTE>`
