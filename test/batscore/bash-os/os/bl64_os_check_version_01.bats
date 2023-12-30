setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_os_check_version: os in list" {

  export BL64_OS_DISTRO="${BL64_OS_ALM}-8.5"
  run bl64_os_check_version "${BL64_OS_ALM}-8.5" "${BL64_OS_CNT}-8.2" "${BL64_OS_RHEL}-8.0"
  assert_success

}

@test "bl64_os_check_version: os not in list, compatibility OFF" {

  export BL64_OS_DISTRO="${BL64_OS_OL}-9.0"
  run bl64_os_check_version "${BL64_OS_ALM}-8.5" "${BL64_OS_CNT}-8.2" "${BL64_OS_RHEL}-8.0"
  assert_failure

}
