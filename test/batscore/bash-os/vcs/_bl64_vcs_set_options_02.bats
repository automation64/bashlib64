setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

}

@test "_bl64_vcs_set_options: common globals are set" {

  assert_not_equal "$BL64_VCS_SET_GIT_NO_PAGER" ''
  assert_not_equal "$BL64_VCS_SET_GIT_QUIET" ''
}
