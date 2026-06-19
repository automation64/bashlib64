@test "bl64_os_is_flavor: match ok, list 1" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  export BL64_OS_FLAVOR="$BL64_OS_FLAVOR_DEBIAN"
  run bl64_os_is_flavor "$BL64_OS_FLAVOR_DEBIAN"
  assert_success
}

@test "bl64_os_is_flavor: match ok, list 3" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  export BL64_OS_FLAVOR="$BL64_OS_FLAVOR_DEBIAN"
  run bl64_os_is_flavor "$BL64_OS_FLAVOR_DEBIAN" "$BL64_OS_FLAVOR_ARCH" "$BL64_OS_FLAVOR_SUSE"
  assert_success
}
