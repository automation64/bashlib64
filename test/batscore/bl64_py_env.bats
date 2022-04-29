setup() {
  . "$DEVBL_TEST_SETUP"

}

@test "bl64_py_env: public constants are set" {
  assert_equal $BL64_PY_ERROR_PIP_VERSION 50
}
