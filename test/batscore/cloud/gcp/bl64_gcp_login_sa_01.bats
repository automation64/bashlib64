setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_gcp_setup || skip 'gcp cli not found'
}

@test "bl64_gcp_login_sa: no args" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_gcp_login_sa
  assert_failure
}

@test "bl64_gcp_login_sa: no project" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_gcp_login_sa '/fake/file'
  assert_failure
}

@test "bl64_gcp_login_sa: no key file" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_gcp_login_sa '/fake/file'
  assert_failure
}
