setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_vcs_set_options: run function" {
  run bl64_vcs_set_options
  assert_success
}
