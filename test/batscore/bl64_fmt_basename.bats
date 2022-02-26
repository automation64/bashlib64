setup() {
  . "$DEVBL64_TEST_BASHLIB64"
  . "${DEVBL64_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-file/load.bash"
}

@test "bl64_fmt_basename: dir/file" {

  output='testfile'
  input='/full/path/to/testfile'
  test="$(bl64_fmt_basename "$input")"
  assert_equal "$test" "$output"

}

@test "bl64_fmt_basename: dir/" {

  output=''
  input='/full/path/to/testfile/'
  test="$(bl64_fmt_basename "$input")"
  assert_equal "$test" "$output"

}
