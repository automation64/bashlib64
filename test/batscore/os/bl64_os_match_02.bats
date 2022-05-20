setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_os_match: os = ALM-8" {

  export BL64_OS_DISTRO="${BL64_OS_ALM}-8.5"
  run bl64_os_match 'ALM-8'
  assert_success

}

@test "bl64_os_match: os = ALM-8.5" {

  export BL64_OS_DISTRO="${BL64_OS_ALM}-8.5"
  run bl64_os_match 'ALM-8.5'
  assert_success

}

@test "bl64_os_match: fail os = ALM-9" {

  export BL64_OS_DISTRO="${BL64_OS_ALM}-8.5"
  run bl64_os_match 'ALM-9'
  assert_failure
  assert_equal $status $BL64_LIB_ERROR_OS_NOT_MATCH

}

@test "bl64_os_match: fail os = ALM-9.5" {

  export BL64_OS_DISTRO="${BL64_OS_ALM}-8.5"
  run bl64_os_match 'ALM-9.5'
  assert_failure
  assert_equal $status $BL64_LIB_ERROR_OS_NOT_MATCH

}
