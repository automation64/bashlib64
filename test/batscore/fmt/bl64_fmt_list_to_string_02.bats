setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_fmt_list_to_string: prefix" {
  expected='a5 a6 a7'

  output="$(printf '%s\n%s\n%s\n' 5 6 7 | bl64_fmt_list_to_string "$BL64_LIB_DEFAULT" 'a')"
  assert_equal "$output" "$expected"

}

@test "bl64_fmt_list_to_string: postfix" {
  expected='5b 6b 7b'

  output="$(printf '%s\n%s\n%s\n' 5 6 7 | bl64_fmt_list_to_string "$BL64_LIB_DEFAULT" "$BL64_LIB_DEFAULT" 'b')"
  assert_equal "$output" "$expected"

}

@test "bl64_fmt_list_to_string: prefix + postfix" {
  expected='a5b a6b a7b'

  output="$(printf '%s\n%s\n%s\n' 5 6 7 | bl64_fmt_list_to_string "$BL64_LIB_DEFAULT" 'a' 'b')"
  assert_equal "$output" "$expected"

}
