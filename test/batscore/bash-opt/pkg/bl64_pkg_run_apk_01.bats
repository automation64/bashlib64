@test "bl64_pkg_run_apk: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_pkg_run_apk
  assert_failure
}
