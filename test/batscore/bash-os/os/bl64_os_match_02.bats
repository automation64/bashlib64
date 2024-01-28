@test "bl64_os_match: os = ALM-8" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export BL64_OS_DISTRO="${BL64_OS_ALM}-8.5"
  run bl64_os_match "${BL64_OS_ALM}-8"
  assert_success

}

@test "bl64_os_match: os = ALM-8.5" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export BL64_OS_DISTRO="${BL64_OS_ALM}-8.5"
  run bl64_os_match "${BL64_OS_ALM}-8.5"
  assert_success

}

@test "bl64_os_match: fail os = ALM-9" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export BL64_OS_DISTRO="${BL64_OS_ALM}-8.5"
  run bl64_os_match "${BL64_OS_ALM}-9"
  assert_failure
  assert_equal $status $BL64_LIB_ERROR_OS_NOT_MATCH

}

@test "bl64_os_match: fail os = ALM-9.5" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export BL64_OS_DISTRO="${BL64_OS_ALM}-8.5"
  run bl64_os_match "${BL64_OS_ALM}-9.5"
  assert_failure
  assert_equal $status $BL64_LIB_ERROR_OS_NOT_MATCH

}

@test "bl64_os_match: os = UB-20" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export BL64_OS_DISTRO="${BL64_OS_UB}-20.04"
  run bl64_os_match "${BL64_OS_UB}-20"
  assert_success

}

@test "bl64_os_match: os = UB-20.04" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export BL64_OS_DISTRO="${BL64_OS_UB}-20.04"
  run bl64_os_match "${BL64_OS_UB}-20.04"
  assert_success

}

@test "bl64_os_match: os = UB-20.4" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export BL64_OS_DISTRO="${BL64_OS_UB}-20.04"
  run bl64_os_match "${BL64_OS_UB}-20.4"
  assert_success

}
