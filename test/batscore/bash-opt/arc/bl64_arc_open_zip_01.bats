setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_arc_open_zip: both parameters are not present" {
  bl64_arc_setup
  run bl64_arc_open_zip
  assert_failure
}

@test "bl64_arc_open_zip: destination parameter is not present" {
  run bl64_arc_open_zip '/dev/null'
  assert_failure
}

@test "bl64_arc_open_zip: destination is invalid" {
  run bl64_arc_open_zip '/dev/null' '/dev/null'
  assert_failure
}
