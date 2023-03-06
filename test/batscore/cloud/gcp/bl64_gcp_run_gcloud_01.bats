setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_gcp_setup || skip 'gcp cli not found'
}

@test "bl64_gcp_run_gcloud: parameter is not present" {
  run bl64_gcp_run_gcloud
  assert_failure
}