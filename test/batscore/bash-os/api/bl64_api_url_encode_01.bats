setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  export printable_all="$TESTMANSH_TEST_SAMPLES/ascii-127/printable-all.txt"
  export printable_alphanumeric="$TESTMANSH_TEST_SAMPLES/ascii-127/printable-alphanumeric.txt"
  export printable_non_alphanumeric="$TESTMANSH_TEST_SAMPLES/ascii-127/printable-non-alphanumeric.txt"
  export url_chars_encoded_url_reserved="$TESTMANSH_TEST_SAMPLES/url/chars-encoded-url-reserved.txt"
  export url_chars_ascii_url_reserved="$TESTMANSH_TEST_SAMPLES/url/chars-ascii-url-reserved.txt"
  export url_chars_ascii_non_alphanumeric="$TESTMANSH_TEST_SAMPLES/url/chars-ascii-non-alphanumeric.txt"
  export url_chars_ascii_alphanumeric="$TESTMANSH_TEST_SAMPLES/url/chars-ascii-alphanumeric.txt"
  export url_chars_ascii_all="$TESTMANSH_TEST_SAMPLES/url/chars-ascii-all.txt"
}

@test "bl64_api_url_encode: printable_non_alphanumeric" {
  output="$(cat "$printable_non_alphanumeric" | bl64_api_url_encode)"
  sample="$(<$url_chars_ascii_non_alphanumeric)"
  assert_equal "$output" "$sample"
}

@test "bl64_api_url_encode: printable_alphanumeric" {
  output="$(cat "$printable_alphanumeric" | bl64_api_url_encode)"
  sample="$(<$url_chars_ascii_alphanumeric)"
  assert_equal "$output" "$sample"
}

@test "bl64_api_url_encode: printable_all" {
  output="$(cat "$printable_all" | bl64_api_url_encode)"
  sample="$(<$url_chars_ascii_all)"
  assert_equal "$output" "$sample"
}

@test "bl64_api_url_encode: url_chars_ascii_reserved" {
  output="$(cat "$url_chars_ascii_url_reserved" | bl64_api_url_encode)"
  sample="$(<$url_chars_encoded_url_reserved)"
  assert_equal "$output" "$sample"
}
