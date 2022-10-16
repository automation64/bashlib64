setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  bl64_arc_setup

}

@test "bl64_arc_open_tar: both parameters are not present" {

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
