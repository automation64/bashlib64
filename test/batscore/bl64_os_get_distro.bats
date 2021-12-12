setup() {
  . "${DEVBL64_TEST}/lib/bashlib64.bash"
}

@test "bl64_os_get_distro: identify platform" {
  [[ "$BL64_OS_DISTRO" != 'UNKNOWN' ]]
}
