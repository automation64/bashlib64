@test "bl64_pkg_run_apk: root privilege" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_pkg_run_apk
  assert_failure
}
