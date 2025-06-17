setup() {
  export sample="$TESTMANSH_TEST_SAMPLES/text_01.txt"
}

@test "bl64_txt_run_uniq: run ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_txt_run_uniq "$sample"
  assert_success
}
