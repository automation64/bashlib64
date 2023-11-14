setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  [[ -x /usr/bin/yq ]] || skip 'command not insttalled'
}

@test "bl64_xsv_run_jq: run command ok" {
  run bl64_xsv_run_jq --help
  assert_success
}
