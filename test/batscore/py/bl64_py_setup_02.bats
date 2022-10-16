setup() {
  export TEST_SANDBOX

  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"

}

@test "bl64_py_setup: create venv" {
  [[ ! -f '/run/.containerenv' ]] && skip 'test-case for container mode'

  target="${TEST_SANDBOX}/venv"
  bl64_py_setup

  run bl64_py_setup "$target"

  assert_success
  assert_dir_exist "$target"
  assert_file_exist "${target}/${BL64_PY_DEF_VENV_CFG}"
  assert_file_exist "$BL64_PY_CMD_PYTHON3"

}

teardown() {
  temp_del "$TEST_SANDBOX"
}
