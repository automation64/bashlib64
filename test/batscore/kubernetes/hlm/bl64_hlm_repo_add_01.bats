@test "bl64_hlm_repo_add: both parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_hlm_repo_add
  assert_failure
}

@test "bl64_hlm_repo_add: 2nd parameter is not present" {
  run bl64_hlm_repo_add '/dev/null'
  assert_failure
}