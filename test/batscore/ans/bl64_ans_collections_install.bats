setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_ans_setup || skip 'no ansible cli found'
}

@test "bl64_ans_collections_install: parameters are not present" {
  run bl64_ans_collections_install
  assert_failure
}
