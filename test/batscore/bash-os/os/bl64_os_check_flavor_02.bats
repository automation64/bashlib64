@test "bl64_os_check_flavor: os in list" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  BL64_OS_FLAVOR="$BL64_OS_FLAVOR_ALPINE"
  run bl64_os_check_flavor "$BL64_OS_FLAVOR_ALPINE" "$BL64_OS_FLAVOR_REDHAT"
  assert_success
}

@test "bl64_os_check_flavor: os not in list" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  BL64_OS_FLAVOR="$BL64_OS_FLAVOR_DEBIAN"
  run bl64_os_check_flavor "$BL64_OS_FLAVOR_ALPINE" "$BL64_OS_FLAVOR_REDHAT"
  assert_failure
}
