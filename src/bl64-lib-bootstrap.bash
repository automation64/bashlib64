#
# Library Bootstrap
#

# Verify that the current shell is supported
if [ -z "$BASH_VERSION" ]; then
  builtin echo "Fatal: BashLib64 is not supported in the current shell (shell: $SHELL)"
  builtin exit 1
elif [ "${BASH_VERSINFO[0]}" -lt 4 ]; then
  builtin echo "Fatal: BashLib64 requires Bash V4 or greater (current-version: ${BASH_VERSION})"
  builtin exit 1
fi

# Do not inherit aliases and commands
builtin unset -f unalias
builtin unset -f command
builtin unset -f set
builtin unalias -a
builtin hash -r

# Disable debugging by default. Can be reactivated with bl64_dbg_*
builtin set +x

# Do not inherit sensitive environment variables
builtin unset CDPATH
builtin unset ENV
builtin unset IFS
builtin unset MAIL
builtin unset MAILPATH
