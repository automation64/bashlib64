@test "bl64_check_path_absolute: dir is absolute" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_path_absolute '/etc'
  assert_success

}

@test "bl64_check_path_absolute: dir is /" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_path_absolute '/'
  assert_success

}

@test "bl64_check_path_absolute: dir is ." {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_path_absolute '.'
  assert_failure

}

@test "bl64_check_path_absolute: file path is relative" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_path_absolute 'path/to/file'
  assert_failure

}

@test "bl64_check_path_absolute: dir is relative" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_path_absolute 'path/to/file/'
  assert_failure

}

@test "bl64_check_path_absolute: ./dir is relative" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_path_absolute './path/to/file/'
  assert_failure

}
