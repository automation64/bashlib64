@test "bl64_os_check_compatibility: os in list, compatibility OFF" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export BL64_LIB_COMPATIBILITY='OFF'
  export BL64_OS_DISTRO="${BL64_OS_ALM}-8.5"
  run bl64_os_check_compatibility "${BL64_OS_ALM}-8.5" "${BL64_OS_CNT}-8.2" "${BL64_OS_RHEL}-8.0"
  assert_success

}

@test "bl64_os_check_compatibility: os version not in list, compatibility OFF" {

  export BL64_LIB_COMPATIBILITY='OFF'
  export BL64_OS_DISTRO="${BL64_OS_ALM}-9.0"
  run bl64_os_check_compatibility "${BL64_OS_ALM}-8.5" "${BL64_OS_CNT}-8.2" "${BL64_OS_RHEL}-8.0"
  assert_failure

}

@test "bl64_os_check_compatibility: os not in list, compatibility OFF" {

  export BL64_LIB_COMPATIBILITY='OFF'
  export BL64_OS_DISTRO="${BL64_OS_OL}-9.0"
  run bl64_os_check_compatibility "${BL64_OS_ALM}-8.5" "${BL64_OS_CNT}-8.2" "${BL64_OS_RHEL}-8.0"
  assert_failure

}
