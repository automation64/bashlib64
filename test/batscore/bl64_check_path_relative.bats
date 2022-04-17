setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"
  set +u # to avoid IFS missing error in run function
}

@test "bl64_check_path_relative: dir is absolute" {

  run bl64_check_path_relative '/etc'
  assert_failure
  assert_equal "$status" $BL64_CHECK_ERROR_PATH_NOT_RELATIVE

}

@test "bl64_check_path_relative: dir is /" {

  run bl64_check_path_relative '/'
  assert_failure
  assert_equal "$status" $BL64_CHECK_ERROR_PATH_NOT_RELATIVE

}

@test "bl64_check_path_relative: dir is ." {

  run bl64_check_path_relative '.'
  assert_success

}

@test "bl64_check_path_relative: file path is relative" {

  run bl64_check_path_relative 'path/to/file'
  assert_success

}

@test "bl64_check_path_relative: dir is relative" {

  run bl64_check_path_relative 'path/to/file/'
  assert_success

}

@test "bl64_check_path_relative: ./dir is relative" {

  run bl64_check_path_relative './path/to/file/'
  assert_success

}

@test "bl64_check_path_relative: directory parameter is not present" {

  run bl64_check_path_relative
  assert_failure

}
