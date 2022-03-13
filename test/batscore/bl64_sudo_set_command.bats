setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_sudo_set_command: commands are set" {
  assert_not_equal "${BL64_SUDO_CMD_SUDO}" ''
  assert_not_equal "${BL64_SUDO_CMD_VISUDO}" ''
  assert_not_equal "${BL64_SUDO_FILE_SUDOERS}" ''
}
