setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  [[ -x "$BL64_OS_CMD_LOCALE" ]] || skip
}

@test "bl64_os_lang_is_available: parameter is not present" {
  run bl64_os_lang_is_available
  assert_failure
}