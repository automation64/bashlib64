@test "bl64_fmt_list_to_string: prefix" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  expected='a5 a6 a7'

  output="$(printf '%s\n%s\n%s\n' 5 6 7 | bl64_fmt_list_to_string "$BL64_VAR_DEFAULT" 'a')"
  assert_equal "$output" "$expected"

}

@test "bl64_fmt_list_to_string: postfix" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  expected='5b 6b 7b'

  output="$(printf '%s\n%s\n%s\n' 5 6 7 | bl64_fmt_list_to_string "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" 'b')"
  assert_equal "$output" "$expected"

}

@test "bl64_fmt_list_to_string: prefix + postfix" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  expected='a5b a6b a7b'

  output="$(printf '%s\n%s\n%s\n' 5 6 7 | bl64_fmt_list_to_string "$BL64_VAR_DEFAULT" 'a' 'b')"
  assert_equal "$output" "$expected"

}
