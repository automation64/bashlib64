setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_mdb_run_mongosh: CLI runs ok" {
  bl64_mdb_setup || skip
  run bl64_mdb_run_mongosh --help
  assert_success
}
