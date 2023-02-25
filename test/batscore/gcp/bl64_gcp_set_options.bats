setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_gcp_setup || skip
}

@test "_bl64_gcp_set_options: common globals are set" {
  assert_not_equal "$BL64_GCP_SET_FORMAT_YAML" ''
  assert_not_equal "$BL64_GCP_SET_FORMAT_TEXT" ''
  assert_not_equal "$BL64_GCP_SET_FORMAT_JSON" ''
}
