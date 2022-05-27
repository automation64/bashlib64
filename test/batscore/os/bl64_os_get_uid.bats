setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_os_get_uid: get current user uid" {
  run bl64_os_get_uid
  assert_success
  assert_not_equal "$output" ''
}

@test "bl64_os_get_uid: get specific user uid" {
  run bl64_os_get_uid 'root'
  assert_success
  assert_equal "$output" '0'
}
