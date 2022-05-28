setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_iam_user_get_id: get current user uid" {
  run bl64_iam_user_get_id
  assert_success
  assert_not_equal "$output" ''
}

@test "bl64_iam_user_get_id: get specific user uid" {
  run bl64_iam_user_get_id 'root'
  assert_success
  assert_equal "$output" '0'
}
