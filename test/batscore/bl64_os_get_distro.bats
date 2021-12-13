setup() {
  . "${DEVBL64_TEST}/lib/bashlib64.bash"
  . "${DEVBL64_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_os_get_distro: identify platform" {
  assert_not_equal "$BL64_OS_DISTRO" 'UNKNOWN'
}
