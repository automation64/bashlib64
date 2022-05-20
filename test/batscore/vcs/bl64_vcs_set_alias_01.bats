setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_vcs_set_alias: run function" {
  run bl64_vcs_set_alias
  assert_success
}
