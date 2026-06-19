@test "bl64_iam_user_get_gid: get current user gid" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_iam_setup
  run bl64_iam_user_get_gid
  assert_success
  assert_not_equal "$output" ''
}

@test "bl64_iam_user_get_gid: get specific user gid" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_iam_setup
  run bl64_iam_user_get_gid 'root'
  assert_success
  assert_equal "$output" '0'
}
