setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"
}

@test "bl64_fmt_basename: /dir/dir/file" {

  output='testfile'
  input='/full/path/to/testfile'
  test="$(bl64_fmt_basename "$input")"
  assert_equal "$test" "$output"

}

@test "bl64_fmt_basename: /dir/file" {

  output='testfile'
  input='/path/testfile'
  test="$(bl64_fmt_basename "$input")"
  assert_equal "$test" "$output"

}

@test "bl64_fmt_basename: dir/dir/file" {

  output='testfile'
  input='path/to/testfile'
  test="$(bl64_fmt_basename "$input")"
  assert_equal "$test" "$output"

}

@test "bl64_fmt_basename: dir/file" {

  output='testfile'
  input='path/testfile'
  test="$(bl64_fmt_basename "$input")"
  assert_equal "$test" "$output"

}

@test "bl64_fmt_basename: /dir/" {

  output=''
  input='/full/path/to/testfile/'
  test="$(bl64_fmt_basename "$input")"
  assert_equal "$test" "$output"

}

@test "bl64_fmt_basename: file" {

  output='testfile'
  input='testfile'
  test="$(bl64_fmt_basename "$input")"
  assert_equal "$test" "$output"

}

@test "bl64_fmt_basename: /" {

  output=''
  input='/'
  test="$(bl64_fmt_basename "$input")"
  assert_equal "$test" "$output"

}
