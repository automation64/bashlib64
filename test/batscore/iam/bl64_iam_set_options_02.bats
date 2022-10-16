setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_iam_setup
}

@test "bl64_iam_set_options: common globals are set" {
  assert_not_equal "$BL64_IAM_SET_USERADD_HOME_PATH" ''
  assert_not_equal "$BL64_IAM_SET_USERADD_CREATE_HOME" ''
}
