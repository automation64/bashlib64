setup() {
  . "$DEVBL_TEST_SETUP"

}

@test "bl64_check_show_undefined: syntax" {

  run bl64_check_show_undefined 'test'
  assert_failure
}
