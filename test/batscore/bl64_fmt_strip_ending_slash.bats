setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"
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
