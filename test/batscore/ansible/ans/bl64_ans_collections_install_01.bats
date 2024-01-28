@test "bl64_ans_collections_install: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_ans_collections_install
  assert_failure
}
