setup() {
  . "$DEVBL_TEST_SETUP"
  bl64_gcp_setup
}

@test "bl64_iam_set_options: common globals are set" {
  assert_not_equal "$BL64_IAM_ALIAS_USERADD" ''
}
