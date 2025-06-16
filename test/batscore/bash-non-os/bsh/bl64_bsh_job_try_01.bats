@test "bl64_bsh_job_try: missing args" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_job_try 3 3
  assert_failure
}
