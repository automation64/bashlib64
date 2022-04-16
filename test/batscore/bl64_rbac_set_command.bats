setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_rbac_set_command: commands are set" {
  assert_not_equal "${BL64_RBAC_CMD_SUDO}" ''
  assert_not_equal "${BL64_RBAC_CMD_VISUDO}" ''
  assert_not_equal "${BL64_RBAC_FILE_SUDOERS}" ''
}

@test "bl64_rbac_set_command: commands are present" {

  assert_file_executable "${BL64_RBAC_CMD_SUDO}"
  assert_file_executable "${BL64_RBAC_CMD_VISUDO}"

}