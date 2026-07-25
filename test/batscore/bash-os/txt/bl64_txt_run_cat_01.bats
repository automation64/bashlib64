@test "bl64_txt_run_cat: run ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_txt_run_cat /etc/passwd
  assert_success
}
