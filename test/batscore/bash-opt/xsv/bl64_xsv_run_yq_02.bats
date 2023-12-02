setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  [[ -x /usr/bin/yq ]] || skip 'command not installed'
  bl64_xsv_setup
}

@test "bl64_xsv_run_yq: run command ok" {
  run bl64_xsv_run_yq --help
  assert_success
}
