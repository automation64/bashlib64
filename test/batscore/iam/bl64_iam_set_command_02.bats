setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_iam_setup

}

@test "bl64_iam_set_command: commands are set" {

  assert_not_equal "${BL64_IAM_CMD_USERADD}" ''
  assert_not_equal "${BL64_IAM_CMD_ID}" ''

}

@test "bl64_iam_set_command: commands are present" {

  assert_file_executable "${BL64_IAM_CMD_USERADD}"
  assert_file_executable "${BL64_IAM_CMD_ID}"

}