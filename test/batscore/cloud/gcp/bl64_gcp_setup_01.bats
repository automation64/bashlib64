setup() {
  [[ -x /usr/bin/gcloud ]] || skip 'gcp cli not found'
}

@test "bl64_gcp_setup: module setup ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_gcp_setup
  assert_success
}

@test "bl64_gcp_setup: invalid path" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_gcp_setup '/1/2/3'
  assert_success
}
