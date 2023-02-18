setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_is_inside_container && skip 'not applicable to container mode'

  bl64_cnt_setup
}

@test "bl64_cnt_set_command: commands are set" {

  assert_not_equal "$BL64_CNT_CMD_PODMAN" ''
  assert_not_equal "$BL64_CNT_CMD_DOCKER" ''

}
