setup() {
  export TEST_SANDBOX

  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  bl64_py_setup

  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"
}

@test "bl64_py_venv_create: create ok" {
  # Force container run
  if [[ ! -f '/run/.containerenv' ]]; then
    skip 'this case can only be tested inside a container'
  fi

  run bl64_py_venv_create "${TEST_SANDBOX}/new"
  assert_success
  assert_dir_exist "${TEST_SANDBOX}/new"
  assert_file_exist "${TEST_SANDBOX}/new/${BL64_PY_DEF_VENV_CFG}"

}


@test "bl64_py_venv_create: create on existing" {
  # Force container run
  if [[ ! -f '/run/.containerenv' ]]; then
    skip 'this case can only be tested inside a container'
  fi

  run bl64_py_venv_create "${TEST_SANDBOX}"
  assert_failure

}

teardown() {
  temp_del "$TEST_SANDBOX"
}
