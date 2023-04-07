setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_fmt_strip_comments: " {
  sample="$(<$TESTMANSH_TEST_SAMPLES/text_without_comments_01.txt)"

  output="$(bl64_fmt_strip_comments $TESTMANSH_TEST_SAMPLES/text_with_comments_01.txt)"
  assert_equal "$output" "$sample"

}
