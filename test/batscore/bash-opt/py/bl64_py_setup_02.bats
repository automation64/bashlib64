setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_is_inside_container || skip 'test-case for container mode'

  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  export TEST_SANDBOX="$(temp_make)"
}

@test "bl64_py_setup: create venv" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  target="${TEST_SANDBOX}/venv"
  bl64_py_setup

  run bl64_py_setup "$target"

  assert_success
  assert_dir_exist "$target"
  assert_file_exist "${target}/${BL64_PY_DEF_VENV_CFG}"
  assert_file_exist "$BL64_PY_CMD_PYTHON3"
}

teardown() {
  [[ -d "$TEST_SANDBOX" ]] && temp_del "$TEST_SANDBOX"
  :
}
