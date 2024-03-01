@test "bl64_os_env: os family set" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
    assert_equal "$BL64_OS_FLAVOR_ALPINE" 'ALPINE'
    assert_equal "$BL64_OS_FLAVOR_DEBIAN" 'DEBIAN'
    assert_equal "$BL64_OS_FLAVOR_FEDORA" 'FEDORA'
    assert_equal "$BL64_OS_FLAVOR_MACOS" 'MACOS'
    assert_equal "$BL64_OS_FLAVOR_REDHAT" 'REDHAT'
    assert_equal "$BL64_OS_FLAVOR_SUSE" 'SUSE'
}
