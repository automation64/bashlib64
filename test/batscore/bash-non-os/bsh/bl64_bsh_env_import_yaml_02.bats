setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  [[ -x /usr/bin/yq ]] || skip 'command not installed'
  bl64_xsv_setup
}

function test_import() {
  bl64_bsh_env_import_yaml "${TESTMANSH_TEST_SAMPLES}/yaml/configuration.yaml"
}

@test "bl64_bsh_env_import_yaml: import configuration" {
  run test_import
  assert_success
}
