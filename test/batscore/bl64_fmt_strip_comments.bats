setup() {
  . "$DEVBL64_TEST_BASHLIB64"
  . "${DEVBL64_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-file/load.bash"
}

@test "bl64_fmt_strip_comments: " {
  sample="$(<$DEVBL64_SAMPLES/text_without_comments_01.txt)"

  output="$(bl64_fmt_strip_comments $DEVBL64_SAMPLES/text_with_comments_01.txt)"
  assert_equal "$output" "$sample"

}
