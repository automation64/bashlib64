setup() {
  [[ -x /usr/bin/yq ]] || skip 'command not installed'
}

@test "bl64_xsv_run_yq: run command ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_xsv_setup
  run bl64_xsv_run_yq --version
  assert_success
}
