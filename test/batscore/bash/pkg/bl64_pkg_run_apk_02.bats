setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_pkg_setup
}

@test "bl64_pkg_run_apk: root privilege" {
  run bl64_pkg_run_apk
  assert_failure
}
