setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"
}

@test "bl64_fmt_dirname: dir/file" {

  output='/full/path/to'
  input='/full/path/to/testfile'
  test="$(bl64_fmt_dirname "$input")"
  assert_equal "$test" "$output"

}

@test "bl64_fmt_dirname: dir/" {

  output='/full/path/to'
  input='/full/path/to/'
  test="$(bl64_fmt_dirname "$input")"
  assert_equal "$test" "$output"

}
