@test "bl64_txt_dump: run ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_txt_dump /etc/passwd
  assert_success
}
