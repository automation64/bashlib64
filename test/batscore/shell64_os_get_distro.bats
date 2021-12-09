setup() {
  SHELL64_LIB="${PROJECT_SHELL64_SRC}"
  . "${SHELL64_LIB}/shell64.bash"
}

@test "1: identify platform()" {
  [[ "$SHELL64_OS_DISTRO" != 'UNKNOWN' ]]
}
