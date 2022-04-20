setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"
}

function _test_bl64_dbg_lib_show_info() {
  bl64_dbg_lib_show_info 'TEST_VAR=1'
}

@test "bl64_dbg_lib_show_info: start dbg" {

  set +u # to avoid IFS missing error in run function
  run _test_bl64_dbg_lib_show_info

  assert_success

}