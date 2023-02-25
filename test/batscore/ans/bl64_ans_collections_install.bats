setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_ans_setup || skip
}

@test "bl64_ans_collections_install: parameters are present" {
  run bl64_ans_collections_install
  assert_failure
}
