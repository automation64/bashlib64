setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_pkg_setup

}

@test "bl64_xsv_run_yq: parameters are not present" {
  run bl64_xsv_run_yq
  assert_failure
}
