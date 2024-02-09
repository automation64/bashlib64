@test "bl64_py_pip_usr_deploy: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_py_pip_usr_deploy
  assert_failure
}