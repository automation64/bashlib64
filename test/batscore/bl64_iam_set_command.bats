setup() {
  . "$DEVBL_TEST_SETUP"

}

@test "bl64_iam_set_command: commands are set" {

  assert_not_equal "${BL64_IAM_CMD_USERADD}" ''

}

@test "bl64_iam_set_command: commands are present" {

  assert_file_executable "${BL64_IAM_CMD_USERADD}"

}