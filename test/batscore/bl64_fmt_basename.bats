setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"
}

@test "bl64_fmt_basename: /dir/dir/file" {
  cmd_status=0
  output='testfile'
  input='/full/path/to/testfile'
  test="$(bl64_fmt_basename "$input")"
  cmd_status=$?
  assert_equal "$cmd_status" 0
  assert_equal "$test" "$output"

}

@test "bl64_fmt_basename: /dir/file" {

  cmd_status=0
  output='testfile'
  input='/path/testfile'
  test="$(bl64_fmt_basename "$input")"
  cmd_status=$?
  assert_equal "$cmd_status" 0
  assert_equal "$test" "$output"

}

@test "bl64_fmt_basename: dir/dir/file" {

  cmd_status=0
  output='testfile'
  input='path/to/testfile'
  test="$(bl64_fmt_basename "$input")"
  cmd_status=$?
  assert_equal "$cmd_status" 0
  assert_equal "$test" "$output"

}

@test "bl64_fmt_basename: dir/file" {

  cmd_status=0
  output='testfile'
  input='path/testfile'
  test="$(bl64_fmt_basename "$input")"
  cmd_status=$?
  assert_equal "$cmd_status" 0
  assert_equal "$test" "$output"

}

@test "bl64_fmt_basename: /dir/" {

  input='/full/path/to/testfile/'
  test="$(bl64_fmt_basename "$input")" || true
  assert_equal "$test" ''

}

@test "bl64_fmt_basename: file" {

  cmd_status=0
  output='testfile'
  input='testfile'
  test="$(bl64_fmt_basename "$input")"
  cmd_status=$?
  assert_equal "$test" "$output"

}

@test "bl64_fmt_basename: /" {

  input='/'
  test="$(bl64_fmt_basename "$input")" || true
  assert_equal "$test" ''

}
