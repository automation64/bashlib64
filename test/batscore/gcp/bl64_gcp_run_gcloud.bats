setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_gcp_setup
}

@test "bl64_gcp_run_gcloud: CLI runs ok" {
  [[ ! -x "$BL64_GCP_CMD_GCLOUD" ]] && skip
  run bl64_gcp_run_gcloud --version
  assert_success
}
