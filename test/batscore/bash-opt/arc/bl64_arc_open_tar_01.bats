@test "bl64_arc_open_tar: both parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_arc_setup
  run bl64_arc_open_tar
  assert_failure
}

@test "bl64_arc_open_tar: destination parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_arc_open_tar '/dev/null'
  assert_failure
}

@test "bl64_arc_open_tar: destination is invalid" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_arc_open_tar '/dev/null' '/dev/null'
  assert_failure
}
