@test "bl64_dbg_env: debug constants are set" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  assert_equal "$BL64_DBG_TARGET_NONE" 'NONE'
  assert_equal "$BL64_DBG_TARGET_APP_TRACE" 'APP_TRACE'
  assert_equal "$BL64_DBG_TARGET_APP_TASK" 'APP_TASK'
  assert_equal "$BL64_DBG_TARGET_APP_CMD" 'APP_CMD'
  assert_equal "$BL64_DBG_TARGET_APP_ALL" 'APP'
  assert_equal "$BL64_DBG_TARGET_APP_CUSTOM_1" 'CUSTOM_1'
  assert_equal "$BL64_DBG_TARGET_APP_CUSTOM_2" 'CUSTOM_2'
  assert_equal "$BL64_DBG_TARGET_APP_CUSTOM_3" 'CUSTOM_3'
  assert_equal "$BL64_DBG_TARGET_LIB_TRACE" 'LIB_TRACE'
  assert_equal "$BL64_DBG_TARGET_LIB_TASK" 'LIB_TASK'
  assert_equal "$BL64_DBG_TARGET_LIB_CMD" 'LIB_CMD'
  assert_equal "$BL64_DBG_TARGET_LIB_ALL" 'LIB'
  assert_equal "$BL64_DBG_TARGET_ALL" 'ALL'
}
