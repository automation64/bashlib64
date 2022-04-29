setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_fmt_env: public constants are set" {
  assert_equal $BL64_FMT_ERROR_NO_BASENAME 50
}
