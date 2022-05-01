setup() {
  . "$DEVBL_TEST_SETUP"

}

@test "bl64_vcs_set_alias: common globals are set" {

  assert_not_equal "$BL64_VCS_ALIAS_GIT" ''

}
