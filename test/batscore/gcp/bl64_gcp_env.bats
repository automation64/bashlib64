setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_gcp_env: constants are set" {
  assert_equal "$BL64_GCP_CONFIGURATION_NAME" '_bl64_gcp_private_configuration_'
  assert_equal "$BL64_GCP_CONFIGURATION_CREATED" "$BL64_LIB_VAR_FALSE"
}
