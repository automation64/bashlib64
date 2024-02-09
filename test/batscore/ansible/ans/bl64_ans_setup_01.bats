setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  [[ -x /opt/ansible/bin/ansible ]] || skip 'no ansible cli found'
}

@test "bl64_ans_setup: module setup - ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_ans_setup
  assert_success
}

@test "bl64_ans_setup: module setup - invalid bin path" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_ans_setup '/no/ansible'
  assert_failure
}
