setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_dbg_set_level: no args" {

  run bl64_dbg_set_level
  assert_failure

}

@test "bl64_dbg_set_level: wrong arg" {

  run bl64_dbg_set_level 'INVALID_VALUE'
  assert_failure

}

@test "bl64_dbg_set_level: valid arg" {

  run bl64_dbg_set_level "$BL64_DBG_TARGET_APP_CMD"
  assert_success

}
