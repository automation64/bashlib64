@test "bl64_os_match: os = BL64_OS_ALM" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export BL64_OS_DISTRO="${BL64_OS_ALM}-8.5"
  run bl64_os_match "$BL64_OS_ALM"
  assert_success

}

@test "bl64_os_match: os = BL64_OS_ALP" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export BL64_OS_DISTRO="${BL64_OS_ALP}-3.0"
  run bl64_os_match "$BL64_OS_ALP"
  assert_success

}

@test "bl64_os_match: os = BL64_OS_CNT" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export BL64_OS_DISTRO="${BL64_OS_CNT}-8.5"
  run bl64_os_match "$BL64_OS_CNT"
  assert_success

}

@test "bl64_os_match: os = BL64_OS_DEB" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export BL64_OS_DISTRO="${BL64_OS_DEB}-10.0"
  run bl64_os_match "$BL64_OS_DEB"
  assert_success

}

@test "bl64_os_match: os = BL64_OS_FD" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export BL64_OS_DISTRO="${BL64_OS_FD}-33.0"
  run bl64_os_match "$BL64_OS_FD"
  assert_success

}

@test "bl64_os_match: os = BL64_OS_OL" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export BL64_OS_DISTRO="${BL64_OS_OL}-8.5"
  run bl64_os_match "$BL64_OS_OL"
  assert_success

}

@test "bl64_os_match: os = BL64_OS_RHEL" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export BL64_OS_DISTRO="${BL64_OS_RHEL}-8.5"
  run bl64_os_match "$BL64_OS_RHEL"
  assert_success

}

@test "bl64_os_match: os = BL64_OS_UB" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export BL64_OS_DISTRO="${BL64_OS_UB}-20.4"
  run bl64_os_match "$BL64_OS_UB"
  assert_success

}
