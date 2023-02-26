setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_gcp_setup || skip
}

@test "_bl64_gcp_set_command: commands are set" {

  assert_not_equal "$BL64_GCP_CMD_GCLOUD" ''

}
