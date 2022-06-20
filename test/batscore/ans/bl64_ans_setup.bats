setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"

  touch "${TEST_SANDBOX}/ansible" "${TEST_SANDBOX}/ansible-galaxy" "${TEST_SANDBOX}/ansible-playbook"
  chmod 755 "${TEST_SANDBOX}/ansible" "${TEST_SANDBOX}/ansible-galaxy" "${TEST_SANDBOX}/ansible-playbook"
}

@test "bl64_ans_setup: module setup - invalid bin path" {
  run bl64_ans_setup '/no/ansible'
  assert_failure
}

@test "bl64_ans_setup: module setup - bin path ok" {
  run bl64_ans_setup "$TEST_SANDBOX"
  assert_success
}

teardown() {
  temp_del "$TEST_SANDBOX"
}
