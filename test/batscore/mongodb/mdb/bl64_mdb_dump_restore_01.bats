setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_mdb_setup || skip 'mongosh cli not found'
}

@test "bl64_mdb_dump_restore: parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_mdb_dump_restore
  assert_failure
}
