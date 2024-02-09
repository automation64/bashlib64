@test "bl64_ans_blank_ansible: run ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_ans_blank_ansible
  assert_success
}
