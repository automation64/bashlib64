@test "bl64_os_match: os = ALM + list" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export BL64_OS_DISTRO="${BL64_OS_ALM}-8.5"
  run bl64_os_match "$BL64_OS_ALM" "$BL64_OS_RHEL"
  assert_success

}

@test "bl64_os_match: os = ALM-8 + list" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export BL64_OS_DISTRO="${BL64_OS_ALM}-8.5"
  run bl64_os_match "${BL64_OS_ALM}-8" "${BL64_OS_RHEL}-8"
  assert_success

}

@test "bl64_os_match: os = DEB-10 + list" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export BL64_OS_DISTRO="${BL64_OS_DEB}-10.0"
  run bl64_os_match "${BL64_OS_DEB}-10" "${BL64_OS_UB}-20"
  assert_success

}

@test "bl64_os_match: os = ALM-8.5 + list" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export BL64_OS_DISTRO="${BL64_OS_ALM}-8.5"
  run bl64_os_match "${BL64_OS_ALM}-8.5" "${BL64_OS_RHEL}-8.5"
  assert_success

}

@test "bl64_os_match: fail os = ALM-9 + list" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export BL64_OS_DISTRO="${BL64_OS_ALM}-8.5"
  run bl64_os_match "${BL64_OS_ALM}-9" "${BL64_OS_RHEL}-10"
  assert_failure
  assert_equal $status $BL64_LIB_ERROR_OS_NOT_MATCH

}

@test "bl64_os_match: fail os = ALM-9.5 + list" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export BL64_OS_DISTRO="${BL64_OS_ALM}-8.5"
  run bl64_os_match "${BL64_OS_ALM}-9.5" "${BL64_OS_RHEL}-10.1"
  assert_failure
  assert_equal $status $BL64_LIB_ERROR_OS_NOT_MATCH

}

@test "bl64_os_match: invalid os = XXX + list" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export BL64_OS_DISTRO="${BL64_OS_ALM}-8.5"
  run bl64_os_match "${BL64_OS_CNT}-8.5" "${BL64_OS_RHEL}-10.1" 'XXX'
  assert_failure
  assert_equal $status $BL64_LIB_ERROR_OS_NOT_MATCH

}
