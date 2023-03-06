setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_mdb_setup || skip 'mongosh cli not found'
}

@test "bl64_mdb_run_mongorestore: parameters are not present" {
  run bl64_mdb_run_mongorestore
  assert_failure
}
