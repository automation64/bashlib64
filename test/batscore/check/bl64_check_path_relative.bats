setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_path_relative: dir is absolute" {

  run bl64_check_path_relative '/etc'
  assert_failure

}

@test "bl64_check_path_relative: dir is /" {

  run bl64_check_path_relative '/'
  assert_failure

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
