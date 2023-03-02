setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_gcp_setup || skip 'gcp cli not found'
}

@test "bl64_gcp_run_gcloud: CLI runs ok" {
  [[ ! -x "$BL64_GCP_CMD_GCLOUD" ]] && skip 'gcp cli not found'
  run bl64_gcp_run_gcloud --version
  assert_success
}
