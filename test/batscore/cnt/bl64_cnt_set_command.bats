setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_cnt_set_command: commands are set" {

  assert_not_equal "$BL64_CNT_CMD_PODMAN" ''
  assert_not_equal "$BL64_CNT_CMD_DOCKER" ''

}
