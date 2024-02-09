setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  [[ -x /usr/bin/mongosh ]] || skip 'mongosh cli not found'
}

@test "bl64_mdb_setup: module setup ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_mdb_setup
  assert_success
}

@test "bl64_mdb_setup: invalid path" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_mdb_setup '/1/2/3'
  assert_failure
}
