@test "_bl64_iam_set_alias: common globals are set" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_iam_setup

  assert_not_equal "$BL64_IAM_ALIAS_USERADD" ''

}
