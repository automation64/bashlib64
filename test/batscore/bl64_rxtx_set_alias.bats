setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_rxtx_set_alias: aliases are set" {

  assert_not_equal "${BL64_RXTX_ALIAS_CURL}" ''
  assert_not_equal "${BL64_RXTX_ALIAS_WGET}" ''

}
