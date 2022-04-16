setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"
}

@test "bl64_py_set_command: commands are set" {
  assert_not_equal "$BL64_PY_CMD_PYTHON3" ''
  assert_not_equal "$BL64_PY_CMD_PYTHON36" ''
  assert_not_equal "$BL64_PY_CMD_PYTHON37" ''
  assert_not_equal "$BL64_PY_CMD_PYTHON38" ''
  assert_not_equal "$BL64_PY_CMD_PYTHON39" ''
  assert_not_equal "$BL64_PY_CMD_PYTHON310" ''

}

@test "bl64_py_set_command: commands are present" {

  assert_file_executable "$BL64_PY_CMD_PYTHON3"

}