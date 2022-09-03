setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_dbg_env: debug constants are set" {
  assert_equal "$BL64_DBG_TARGET_NONE" 'APP0'
  assert_equal "$BL64_DBG_TARGET_APP_TRACE" 'APP1'
  assert_equal "$BL64_DBG_TARGET_APP_TASK" 'APP2'
  assert_equal "$BL64_DBG_TARGET_APP_CMD" 'APP3'
  assert_equal "$BL64_DBG_TARGET_APP_ALL" 'APP4'
  assert_equal "$BL64_DBG_TARGET_APP_CUSTOM_1" 'CST1'
  assert_equal "$BL64_DBG_TARGET_APP_CUSTOM_2" 'CST2'
  assert_equal "$BL64_DBG_TARGET_APP_CUSTOM_3" 'CST3'
  assert_equal "$BL64_DBG_TARGET_LIB_TRACE" 'LIB1'
  assert_equal "$BL64_DBG_TARGET_LIB_TASK" 'LIB2'
  assert_equal "$BL64_DBG_TARGET_LIB_CMD" 'LIB3'
  assert_equal "$BL64_DBG_TARGET_LIB_ALL" 'LIB4'
  assert_equal "$BL64_DBG_TARGET_ALL" 'ALL'
}
