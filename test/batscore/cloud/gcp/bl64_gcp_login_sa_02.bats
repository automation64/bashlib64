setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_gcp_setup || skip 'gcp cli not found'
}

@test "bl64_gcp_login_sa: file parameter not existing" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_gcp_login_sa '/xxx/yy/zzz/not_existing' 'test'
  assert_failure
}
