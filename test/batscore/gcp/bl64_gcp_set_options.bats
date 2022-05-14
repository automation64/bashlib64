setup() {
  . "$DEVBL_TEST_SETUP"
  bl64_gcp_setup
}

@test "bl64_gcp_set_options: common globals are set" {
  assert_not_equal "$BL64_GCP_SET_FORMAT_YAML" ''
  assert_not_equal "$BL64_GCP_SET_FORMAT_TEXT" ''
  assert_not_equal "$BL64_GCP_SET_FORMAT_JSON" ''
}
