@test "bl64_fmt_strip_starting_slash: /" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  output='/'
  input='/'
  test="$(bl64_fmt_strip_starting_slash "$input")"
  assert_equal "$test" "$output"

}

@test "bl64_fmt_strip_starting_slash: /dir/file" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  output='full/path/to/testfile'
  input='/full/path/to/testfile'
  test="$(bl64_fmt_strip_starting_slash "$input")"
  assert_equal "$test" "$output"

}

@test "bl64_fmt_strip_starting_slash: dir/file" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  output='full/path/to/testfile'
  input='full/path/to/testfile'
  test="$(bl64_fmt_strip_starting_slash "$input")"
  assert_equal "$test" "$output"

}

@test "bl64_fmt_strip_starting_slash: /dir/file/" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  output='full/path/to/testfile/'
  input='/full/path/to/testfile/'
  test="$(bl64_fmt_strip_starting_slash "$input")"
  assert_equal "$test" "$output"

}

@test "bl64_fmt_strip_starting_slash: dir/file/" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  output='full/path/to/testfile/'
  input='full/path/to/testfile/'
  test="$(bl64_fmt_strip_starting_slash "$input")"
  assert_equal "$test" "$output"

}
