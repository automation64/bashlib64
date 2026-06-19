setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  TEST_SANDBOX="$(temp_make)"
}

@test "bl64_rxtx_github_get_asset: get ok, latest, new file" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  export TEST_FILE="${TEST_SANDBOX}/test_file"
  run bl64_rxtx_github_get_asset \
    "$DEV_TEST_VALUE_GIT_OWNER" \
    "$DEV_TEST_VALUE_GIT_ASSET_REPO" \
    'latest' \
    "$DEV_TEST_VALUE_GIT_ASSET_FILE" \
    "$TEST_FILE"
  assert_success
}

teardown() {
  temp_del "$TEST_SANDBOX"
}
