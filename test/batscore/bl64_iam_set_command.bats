setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_iam_set_command: commands are set" {

  assert_not_equal "${BL64_IAM_CMD_USERADD}" ''

}

@test "bl64_iam_set_command: commands are present" {

  assert_file_executable "${BL64_IAM_CMD_USERADD}"

}