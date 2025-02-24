@test "bl64_fmt_list_convert_to_string: printf" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  expected='5 6 7'

  output="$(printf '%s\n%s\n%s\n' 5 6 7 | bl64_fmt_list_convert_to_string)"
  assert_equal "$output" "$expected"

}

@test "bl64_fmt_list_convert_to_string: find" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  output="$(bl64_fs_find_files "$TESTMANSH_TEST_SAMPLES/dir_01" | bl64_fmt_list_convert_to_string)"
  assert_output --partial "$TESTMANSH_TEST_SAMPLES/dir_01"

}
