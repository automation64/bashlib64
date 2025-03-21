#
# Library Bootstrap
#

# Verify that the current shell is supported
if [ -z "$BASH_VERSION" ]; then
  echo "Fatal: BashLib64 is not supported in the current shell (shell: $SHELL)"
  exit 1
elif [ "${BASH_VERSINFO[0]}" -lt 4 ]; then
  echo "Fatal: BashLib64 requires Bash V4 or greater (current-version: ${BASH_VERSION})"
  exit 1
fi

# Do not inherit aliases and commands
builtin unset -f unalias
builtin unalias -a
builtin unset -f command
builtin hash -r

# Normalize shtop defaults
builtin shopt -qu \
  'dotglob' \
  'extdebug' \
  'failglob' \
  'globstar' \
  'gnu_errfmt' \
  'huponexit' \
  'lastpipe' \
  'login_shell' \
  'nocaseglob' \
  'nocasematch' \
  'nullglob' \
  'xpg_echo'
builtin shopt -qs \
  'extquote'

# Ensure pipeline exit status is failed when any cmd fails
builtin set -o 'pipefail'

# Enable error processing
builtin set -o 'errtrace'
builtin set -o 'functrace'

# Disable fast-fail. Developer must implement error handling (check for exit status)
builtin set +o 'errexit'

# Reset bash set options to defaults
builtin set -o 'braceexpand'
builtin set -o 'hashall'
builtin set +o 'allexport'
builtin set +o 'histexpand'
builtin set +o 'history'
builtin set +o 'ignoreeof'
builtin set +o 'monitor'
builtin set +o 'noclobber'
builtin set +o 'noglob'
builtin set +o 'nolog'
builtin set +o 'notify'
builtin set +o 'onecmd'
builtin set +o 'posix'

# Do not set/unset - Breaks bats-core
# set -o 'keyword'
# set -o 'noexec'

# Do not inherit sensitive environment variables
builtin unset CDPATH
builtin unset ENV
builtin unset IFS
builtin unset MAIL
builtin unset MAILPATH
