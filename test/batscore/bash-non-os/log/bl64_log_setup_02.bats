@test "bl64_log_setup: repo ok, existing" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_log_setup /tmp
  assert_success

}

@test "bl64_log_setup: repo ok, new" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_log_setup '/tmp/new-repo'
  assert_success

}
