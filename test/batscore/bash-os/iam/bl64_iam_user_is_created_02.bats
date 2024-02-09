@test "bl64_iam_user_is_created: check existing user" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_iam_setup
  run bl64_iam_user_is_created 'root'
  assert_success
}

@test "bl64_iam_user_is_created: check non existing user" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_iam_setup
  run bl64_iam_user_is_created 'fake_user'
  assert_failure
}
