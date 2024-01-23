@test "bl64_fmt_dirname: /dir/file" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  output='/full/path/to'
  input='/full/path/to/testfile'
  test="$(bl64_fmt_dirname "$input")"
  assert_equal "$test" "$output"

}

@test "bl64_fmt_dirname: /dir/dir/" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  output='/full/path/to'
  input='/full/path/to/'
  test="$(bl64_fmt_dirname "$input")"
  assert_equal "$test" "$output"

}

@test "bl64_fmt_dirname: dir/file" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  output='full/path/to'
  input='full/path/to/testfile'
  test="$(bl64_fmt_dirname "$input")"
  assert_equal "$test" "$output"

}

@test "bl64_fmt_dirname: dir/dir/" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  output='full/path/to'
  input='full/path/to/'
  test="$(bl64_fmt_dirname "$input")"
  assert_equal "$test" "$output"

}

@test "bl64_fmt_dirname: dir" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  output='testdir'
  input='testdir'
  test="$(bl64_fmt_dirname "$input")"
  assert_equal "$test" "$output"

}

@test "bl64_fmt_dirname: /dir" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  output='/'
  input='/testdir'
  test="$(bl64_fmt_dirname "$input")"
  assert_equal "$test" "$output"

}

@test "bl64_fmt_dirname: /" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  output='/'
  input='/'
  test="$(bl64_fmt_dirname "$input")"
  assert_equal "$test" "$output"

}
