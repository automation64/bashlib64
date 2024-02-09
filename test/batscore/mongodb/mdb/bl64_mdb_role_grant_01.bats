setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_mdb_setup || skip 'mongosh cli not found'
}

@test "bl64_mdb_role_grant: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_mdb_role_grant
  assert_failure
}

@test "bl64_mdb_role_grant: 2nd parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_mdb_role_grant '/dev/null'
  assert_failure
}

@test "bl64_mdb_role_grant: 3th parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_mdb_role_grant '/dev/null' '/dev/null'
  assert_failure
}
