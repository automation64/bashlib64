setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
#  bl64_ans_setup || skip 'no ansible cli found'
}

@test "bl64_ans_setup: module setup - ok" {
  run bl64_ans_setup
  assert_success
}

@test "bl64_ans_setup: module setup - invalid bin path" {
  run bl64_ans_setup '/no/ansible'
  assert_failure
}
