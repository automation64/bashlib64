setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_gcp_set_command: commands are set" {

  assert_not_equal "$BL64_GCP_CMD_GCLOUD" ''

}
