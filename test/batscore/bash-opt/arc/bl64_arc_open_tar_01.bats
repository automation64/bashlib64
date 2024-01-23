setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_arc_open_tar: both parameters are not present" {
  bl64_arc_setup
  run bl64_arc_open_tar
  assert_failure
}

@test "bl64_arc_open_tar: destination parameter is not present" {
  run bl64_arc_open_tar '/dev/null'
  assert_failure
}

@test "bl64_arc_open_tar: destination is invalid" {
  run bl64_arc_open_tar '/dev/null' '/dev/null'
  assert_failure
}
