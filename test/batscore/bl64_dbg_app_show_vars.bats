setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"
}

function _test_bl64_dbg_app_show_vars() {
  export TEST_VAR=123
  bl64_dbg_app_show_vars 'TEST_VAR'
}

@test "bl64_dbg_app_show_vars: start dbg" {

  set +u # to avoid IFS missing error in run function
  run _test_bl64_dbg_app_show_vars

  assert_success

}
