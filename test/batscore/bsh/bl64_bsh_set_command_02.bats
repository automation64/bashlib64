setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

}

@test "bl64_bsh_set_command: commands are set" {

  assert_not_equal "${BL64_BSH_VERSION}" ''

}
