setup() {
  export sample="$TESTMANSH_TEST_SAMPLES/text_01.txt"
}

@test "bl64_txt_run_fmt: run ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_txt_run_fmt "$sample"
  assert_success
}
