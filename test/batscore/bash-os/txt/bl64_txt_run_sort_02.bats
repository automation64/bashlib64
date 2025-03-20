setup() {
  export sample="$TESTMANSH_TEST_SAMPLES/text_01.txt"
}

@test "bl64_txt_run_sort: run ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_txt_run_sort "$sample"
  assert_success
}
