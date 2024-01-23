@test "bl64_dbg_set_level: no args" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_dbg_set_level
  assert_failure

}

@test "bl64_dbg_set_level: wrong arg" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_dbg_set_level 'INVALID_VALUE'
  assert_failure

}

@test "bl64_dbg_set_level: valid arg" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_dbg_set_level "$BL64_DBG_TARGET_APP_CMD"
  assert_success

}
