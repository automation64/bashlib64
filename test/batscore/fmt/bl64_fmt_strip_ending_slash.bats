setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_fmt_strip_ending_slash: /" {

  output='/'
  input='/'
  test="$(bl64_fmt_strip_ending_slash "$input")"
  assert_equal "$test" "$output"

}

@test "bl64_fmt_strip_ending_slash: /dir/file" {

  output='/full/path/to/testfile'
  input='/full/path/to/testfile'
  test="$(bl64_fmt_strip_ending_slash "$input")"
  assert_equal "$test" "$output"

}

@test "bl64_fmt_strip_ending_slash: dir/file" {

  output='full/path/to/testfile'
  input='full/path/to/testfile'
  test="$(bl64_fmt_strip_ending_slash "$input")"
  assert_equal "$test" "$output"

}

@test "bl64_fmt_strip_ending_slash: /dir/file/" {

  output='/full/path/to/testfile'
  input='/full/path/to/testfile/'
  test="$(bl64_fmt_strip_ending_slash "$input")"
  assert_equal "$test" "$output"

}

@test "bl64_fmt_strip_ending_slash: dir/file/" {

  output='full/path/to/testfile'
  input='full/path/to/testfile/'
  test="$(bl64_fmt_strip_ending_slash "$input")"
  assert_equal "$test" "$output"

}
