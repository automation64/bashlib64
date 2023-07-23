# Do not inherit aliases and commands
builtin unset -f unalias
builtin unalias -a
builtin unset -f command
builtin hash -r

# Normalize shtop defaults
shopt -qu \
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
shopt -qs \
  'extquote'

# Ensure pipeline exit status is failed when any cmd fails
set -o 'pipefail'

# Enable error processing
set -o 'errtrace'
set -o 'functrace'

# Disable fast-fail. Developer must implement error handling (check for exit status)
set +o 'errexit'

# Reset bash set options to defaults
set -o 'braceexpand'
set -o 'hashall'
set +o 'allexport'
set +o 'histexpand'
set +o 'history'
set +o 'ignoreeof'
set +o 'monitor'
set +o 'noclobber'
set +o 'noglob'
set +o 'nolog'
set +o 'notify'
set +o 'onecmd'
set +o 'posix'

# Do not set/unset - Breaks bats-core
# set -o 'keyword'
# set -o 'noexec'

# Do not inherit sensitive environment variables
unset MAIL
unset ENV
unset IFS
unset TMPDIR

# Normalize terminal settings
TERM="${TERM:-vt100}"
