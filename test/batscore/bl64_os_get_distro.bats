setup() {
  . "${DEVBL64_TEST}/lib/bashlib64.bash"
}

@test "identify platform" {
  [[ "$BL64_OS_DISTRO" != 'UNKNOWN' ]]
}
