setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_mdb_setup || skip 'mongosh cli not found'
}

@test "bl64_mdb_setup: module setup ok" {
  run bl64_mdb_setup
  assert_success
}

@test "bl64_mdb_setup: invalid path" {
  run bl64_mdb_setup '/1/2/3'
  assert_failure
}
