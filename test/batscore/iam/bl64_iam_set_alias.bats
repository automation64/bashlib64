setup() {
  . "$DEVBL_TEST_SETUP"

}

@test "bl64_iam_set_alias: common globals are set" {

  assert_not_equal "$BL64_IAM_ALIAS_USERADD" ''

}
