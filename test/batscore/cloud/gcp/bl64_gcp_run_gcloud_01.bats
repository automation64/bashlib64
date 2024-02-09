@test "bl64_gcp_run_gcloud: parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_gcp_run_gcloud
  assert_failure
}