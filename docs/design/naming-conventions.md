# BashLib64 - Naming Conventions

- [BashLib64 - Naming Conventions](#bashlib64---naming-conventions)
  - [Function Names](#function-names)
    - [Internal](#internal)
    - [Generic Action](#generic-action)
    - [Attribute Getter / Setter](#attribute-getter--setter)
    - [Flag](#flag)
    - [Command Runner](#command-runner)
  - [Variable Names](#variable-names)
    - [Reserved](#reserved)
    - [Global Internal](#global-internal)
    - [Global Generic](#global-generic)
    - [Attribute name prefix](#attribute-name-prefix)

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

### Reserved

- `<MODULE>_MODULE`

### Global Internal

- `_<VARIABLE>`

### Global Generic

- `<MODULE>[_OBJECT]_<ATTRIBUTE>`

### Attribute name prefix

- `_ALIAS_<ATTRIBUTE>`: external command shell alias
- `_CFG_<ATTRIBUTE>`: external command configuration setting
- `_CMD_<ATTRIBUTE>`: full path to external command
- `_PATH_<ATTRIBUTE>`: full path to file or directory
- `_SET_<ATTRIBUTE>`: external command command line option
- `_TXT_<ATTRIBUTE>`: localized text
