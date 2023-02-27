setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_gcp_setup || skip 'gcp cli not found'
}

@test "bl64_gcp_env: constants are set" {
  assert_equal "$BL64_GCP_CONFIGURATION_NAME" 'bl64_gcp_configuration_private'
  assert_equal "$BL64_GCP_CONFIGURATION_CREATED" "$BL64_VAR_FALSE"
}
