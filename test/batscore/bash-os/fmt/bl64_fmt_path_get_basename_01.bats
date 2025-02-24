@test "bl64_fmt_path_get_basename: /dir/dir/file" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  cmd_status=0
  output='testfile'
  input='/full/path/to/testfile'
  test="$(bl64_fmt_path_get_basename "$input")"
  cmd_status=$?
  assert_equal "$cmd_status" 0
  assert_equal "$test" "$output"

}

@test "bl64_fmt_path_get_basename: /dir/file" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  cmd_status=0
  output='testfile'
  input='/path/testfile'
  test="$(bl64_fmt_path_get_basename "$input")"
  cmd_status=$?
  assert_equal "$cmd_status" 0
  assert_equal "$test" "$output"

}

@test "bl64_fmt_path_get_basename: dir/dir/file" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  cmd_status=0
  output='testfile'
  input='path/to/testfile'
  test="$(bl64_fmt_path_get_basename "$input")"
  cmd_status=$?
  assert_equal "$cmd_status" 0
  assert_equal "$test" "$output"

}

@test "bl64_fmt_path_get_basename: dir/file" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  cmd_status=0
  output='testfile'
  input='path/testfile'
  test="$(bl64_fmt_path_get_basename "$input")"
  cmd_status=$?
  assert_equal "$cmd_status" 0
  assert_equal "$test" "$output"

}

@test "bl64_fmt_path_get_basename: /dir/" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  input='/full/path/to/testfile/'
  test="$(bl64_fmt_path_get_basename "$input")" || true
  assert_equal "$test" ''

}

@test "bl64_fmt_path_get_basename: file" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  cmd_status=0
  output='testfile'
  input='testfile'
  test="$(bl64_fmt_path_get_basename "$input")"
  cmd_status=$?
  assert_equal "$test" "$output"

}

@test "bl64_fmt_path_get_basename: /" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  input='/'
  test="$(bl64_fmt_path_get_basename "$input")" || true
  assert_equal "$test" ''

}
