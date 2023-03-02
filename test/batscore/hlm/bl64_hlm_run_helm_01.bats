setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_hlm_repo_add: both parameters are not present" {
  run bl64_hlm_repo_add
  assert_failure
}

@test "bl64_hlm_repo_add: 2nd parameter is not present" {
  run bl64_hlm_repo_add '/dev/null'
  assert_failure
}

@test "bl64_hlm_repo_add: 3th parameter is not present" {
  run bl64_hlm_repo_add '/dev/null' '/dev/null'
  assert_failure
}

@test "bl64_hlm_repo_add: 4th parameter is not present" {
  run bl64_hlm_repo_add '/dev/null' '/dev/null' '/dev/null'
  assert_failure
}
