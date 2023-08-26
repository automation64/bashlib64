setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  export sample="$(<$TESTMANSH_TEST_SAMPLES/text_without_comments_01.txt)"
  export input="$TESTMANSH_TEST_SAMPLES/text_with_comments_01.txt"
  export input2="$TESTMANSH_TEST_SAMPLES/text_without_comments_01.txt"
}

@test "bl64_txt_strip_comments: file, ok" {
  output="$(bl64_txt_strip_comments "$input")"
  assert_equal "$output" "$sample"
}

@test "bl64_txt_strip_comments: stdin, ok" {
  output="$(cat "$input" | bl64_txt_strip_comments "$BL64_TXT_FLAG_STDIN")"
  assert_equal "$output" "$sample"
}

@test "bl64_txt_strip_comments: file, no comments ok" {
  output="$(bl64_txt_strip_comments "$input2")"
  assert_equal "$output" "$sample"
}
