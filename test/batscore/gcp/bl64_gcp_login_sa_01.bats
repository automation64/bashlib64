setup() {
  . "$DEVBL_TEST_SETUP"
  bl64_gcp_setup
}

@test "bl64_gcp_login_sa: no args" {
  run bl64_gcp_login_sa
  assert_failure
}

@test "bl64_gcp_login_sa: no project" {
  run bl64_gcp_login_sa '/fake/file'
  assert_failure
}

@test "bl64_gcp_login_sa: no key file" {
  run bl64_gcp_login_sa '/fake/file'
  assert_failure
}
