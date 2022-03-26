setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"
}

function _test_bl64_dbg_app_show() {
  bl64_dbg_app_show 'TEST_VAR=1'
}

@test "bl64_dbg_app_show: start dbg" {

  set +u # to avoid IFS missing error in run function
  run _test_bl64_dbg_app_show

  assert_success

}
