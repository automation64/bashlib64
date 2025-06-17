@test "bl64_bsh_job_try: run ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_job_try 3 3 echo test
  assert_success
}
