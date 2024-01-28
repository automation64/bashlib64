@test "bl64_os_check_compatibility: full list, supported, compatibility OFF" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export BL64_LIB_COMPATIBILITY='ON'
  export BL64_OS_DISTRO="${BL64_OS_ALM}-8.5"
  run bl64_os_check_compatibility \
    "${BL64_OS_ALM}-8" "${BL64_OS_ALM}-9" \
    "${BL64_OS_ALP}-3" \
    "${BL64_OS_CNT}-7" "${BL64_OS_CNT}-8" "${BL64_OS_CNT}-9" \
    "${BL64_OS_DEB}-9" "${BL64_OS_DEB}-10" "${BL64_OS_DEB}-11" \
    "${BL64_OS_FD}-33" "${BL64_OS_FD}-34" "${BL64_OS_FD}-35" "${BL64_OS_FD}-36" "${BL64_OS_FD}-37" "${BL64_OS_FD}-38" "${BL64_OS_FD}-39" \
    "${BL64_OS_OL}-7" "${BL64_OS_OL}-8" "${BL64_OS_OL}-9" \
    "${BL64_OS_RCK}-8" "${BL64_OS_RCK}-9" \
    "${BL64_OS_RHEL}-8" "${BL64_OS_RHEL}-9" \
    "${BL64_OS_SLES}-15" \
    "${BL64_OS_UB}-18" "${BL64_OS_UB}-20" "${BL64_OS_UB}-21" "${BL64_OS_UB}-22" "${BL64_OS_UB}-23"
  assert_success

}

@test "bl64_os_check_compatibility: full list, not supported, compatibility OFF" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export BL64_LIB_COMPATIBILITY='ON'
  export BL64_OS_DISTRO="${BL64_OS_ALM}-5.0"
  run bl64_os_check_compatibility \
    "${BL64_OS_ALM}-8" "${BL64_OS_ALM}-9" \
    "${BL64_OS_ALP}-3" \
    "${BL64_OS_CNT}-7" "${BL64_OS_CNT}-8" "${BL64_OS_CNT}-9" \
    "${BL64_OS_DEB}-9" "${BL64_OS_DEB}-10" "${BL64_OS_DEB}-11" \
    "${BL64_OS_FD}-33" "${BL64_OS_FD}-34" "${BL64_OS_FD}-35" "${BL64_OS_FD}-36" "${BL64_OS_FD}-37" "${BL64_OS_FD}-38" "${BL64_OS_FD}-39" \
    "${BL64_OS_OL}-7" "${BL64_OS_OL}-8" "${BL64_OS_OL}-9" \
    "${BL64_OS_RCK}-8" "${BL64_OS_RCK}-9" \
    "${BL64_OS_RHEL}-8" "${BL64_OS_RHEL}-9" \
    "${BL64_OS_SLES}-15" \
    "${BL64_OS_UB}-18" "${BL64_OS_UB}-20" "${BL64_OS_UB}-21" "${BL64_OS_UB}-22" "${BL64_OS_UB}-23"
  assert_success
}
