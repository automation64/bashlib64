setup() {
  BL64_LIB_STRICT=0
  . "$DEVBL64_TEST_BASHLIB64"
  . "${DEVBL64_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-file/load.bash"

  . "${DEVBL64_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-file/load.bash"
}

@test "bl64_arc_open_tar: both parameters are not present" {

  run bl64_arc_open_tar
  assert_equal "$status" $BL64_ARC_ERROR_MISSING_PARAMETER

}

@test "bl64_arc_open_tar: destination parameter is not present" {

  run bl64_arc_open_tar '/dev/null'
  assert_equal "$status" $BL64_ARC_ERROR_MISSING_PARAMETER

}

@test "bl64_arc_open_tar: destination is invalid" {

  run bl64_arc_open_tar '/dev/null' '/dev/null'
  assert_equal "$status" $BL64_ARC_ERROR_INVALID_DESTINATION

}