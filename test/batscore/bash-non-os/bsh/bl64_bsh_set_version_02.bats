@test "_bl64_bsh_set_version: commands are set" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  assert_not_equal "${BL64_BSH_VERSION_BASH}" ''
}
