@test "bl64_os_lang_is_available: parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  [[ -x "$BL64_OS_CMD_LOCALE" ]] || skip
  run bl64_os_lang_is_available
  assert_failure
}