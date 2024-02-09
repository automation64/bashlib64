@test "bl64_txt_run_awk: run ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  expected='hello world'

  run bl64_txt_run_awk -v test="$expected" 'END{ print test }' < /dev/null
  assert_success
  assert_output "$expected"

}
