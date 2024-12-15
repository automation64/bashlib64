@test "bl64_dbg_lib_dryrun_show: run ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_dbg_lib_dryrun_show 'test'
  assert_success
}
