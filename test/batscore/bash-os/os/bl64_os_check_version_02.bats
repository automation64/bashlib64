@test "bl64_os_check_version: os version in list" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export BL64_OS_DISTRO="${BL64_OS_ALM}-8.5"
  run bl64_os_check_version "${BL64_OS_ALM}-8.5" "${BL64_OS_CNT}-8.2" "${BL64_OS_RHEL}-8.0"
  assert_success

}

@test "bl64_os_check_version: os version not in list" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export BL64_OS_DISTRO="${BL64_OS_ALM}-9.0"
  run bl64_os_check_version "${BL64_OS_ALM}-8.5" "${BL64_OS_CNT}-8.2" "${BL64_OS_RHEL}-8.0"
  assert_failure

}

@test "bl64_os_check_version: os not in list" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export BL64_OS_DISTRO="${BL64_OS_OL}-9.0"
  run bl64_os_check_version "${BL64_OS_ALM}-8.5" "${BL64_OS_CNT}-8.2" "${BL64_OS_RHEL}-8.0"
  assert_failure

}
