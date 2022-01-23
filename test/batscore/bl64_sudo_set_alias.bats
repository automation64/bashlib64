setup() {
  . "$DEVBL64_TEST_BASHLIB64"
  . "${DEVBL64_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_sudo_set_alias: common globals are set" {

  bl64_sudo_set_alias

  assert_not_equal "$BL64_SUDO_ALIAS_SUDO_ENV" ''

}
