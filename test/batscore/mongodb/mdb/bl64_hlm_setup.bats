setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_mdb_setup: module setup ok" {
  run bl64_mdb_setup
  assert_success
}
