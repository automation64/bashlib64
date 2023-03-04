setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  [[ -x "$BL64_OS_CMD_LOCALE" ]] || skip
}

@test "bl64_os_lang_is_available: locale is present" {
  run bl64_os_lang_is_available 'C'
  assert_success
}

@test "bl64_os_lang_is_available: locale is not present" {
  run bl64_os_lang_is_available 'XXX'
  assert_failure
}
