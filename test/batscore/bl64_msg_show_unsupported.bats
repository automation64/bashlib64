setup() {
  . "$DEVBL_TEST_SETUP"

}

@test "bl64_msg_show_unsupported: syntax" {

  run bl64_msg_show_unsupported 'test'
  assert_success
}
