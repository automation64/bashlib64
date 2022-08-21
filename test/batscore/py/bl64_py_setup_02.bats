setup() {
  export TEST_SANDBOX

  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"

}

@test "bl64_py_setup: create venv" {
  # Force container run
  if [[ ! -f '/run/.containerenv' ]]; then
    skip 'this case can only be tested inside a container'
  fi

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
