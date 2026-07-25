@test "bl64_txt_dump: no args" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_txt_dump
  assert_failure
}

@test "bl64_txt_dump: no file" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_txt_dump /no/such/file
  assert_failure
}
