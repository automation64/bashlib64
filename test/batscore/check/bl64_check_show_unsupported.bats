setup() {
  . "$DEVBL_TEST_SETUP"

}

@test "bl64_check_show_unsupported: syntax" {

  run bl64_check_show_unsupported 'test'
  assert_failure
}
