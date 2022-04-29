setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_check_path_absolute: dir is absolute" {

  run bl64_check_path_absolute '/etc'
  assert_success

}

@test "bl64_check_path_absolute: dir is /" {

  run bl64_check_path_absolute '/'
  assert_success

}

@test "bl64_check_path_absolute: dir is ." {

  run bl64_check_path_absolute '.'
  assert_failure
  assert_equal "$status" $BL64_CHECK_ERROR_PATH_NOT_ABSOLUTE

}

@test "bl64_check_path_absolute: file path is relative" {

  run bl64_check_path_absolute 'path/to/file'
  assert_failure
  assert_equal "$status" $BL64_CHECK_ERROR_PATH_NOT_ABSOLUTE

}

@test "bl64_check_path_absolute: dir is relative" {

  run bl64_check_path_absolute 'path/to/file/'
  assert_failure
  assert_equal "$status" $BL64_CHECK_ERROR_PATH_NOT_ABSOLUTE

}

@test "bl64_check_path_absolute: ./dir is relative" {

  run bl64_check_path_absolute './path/to/file/'
  assert_failure
  assert_equal "$status" $BL64_CHECK_ERROR_PATH_NOT_ABSOLUTE

}

@test "bl64_check_path_absolute: directory parameter is not present" {

  run bl64_check_path_absolute
  assert_failure

}

