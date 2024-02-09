@test "bl64_cnt_run_podman: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_cnt_run_podman
  assert_failure
}