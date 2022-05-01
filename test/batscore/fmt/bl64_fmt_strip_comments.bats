setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_fmt_strip_comments: " {
  sample="$(<$DEVBL_SAMPLES/text_without_comments_01.txt)"

  output="$(bl64_fmt_strip_comments $DEVBL_SAMPLES/text_with_comments_01.txt)"
  assert_equal "$output" "$sample"

}
