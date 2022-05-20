setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_fmt_list_to_string: printf" {
  expected='5 6 7'

  output="$(printf '%s\n%s\n%s\n' 5 6 7 | bl64_fmt_list_to_string)"
  assert_equal "$output" "$expected"

}

@test "bl64_fmt_list_to_string: find" {

  output="$(bl64_fs_find_files "$DEVBL_SAMPLES/dir_01" | bl64_fmt_list_to_string)"
  assert_output --partial "$DEVBL_SAMPLES/dir_01"

}
