setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

}

@test "bl64_pkg_repository_add: no args" {
  bl64_os_match "${BL64_OS_FD}" "${BL64_OS_RHEL}" "${BL64_OS_ALM}" "${BL64_OS_RCK}" "${BL64_OS_CNT}" "${BL64_OS_OL}" && skip 'RedHat based only'
  [[ ! -f '/run/.containerenv' ]] && skip 'test-case for container mode'
  run $BL64_RBAC_ALIAS_SUDO_ENV /usr/bin/env bash -c "source $DEVBL_TEST_BASHLIB64; bl64_pkg_repository_add azure_cli https://packages.microsoft.com/yumrepos/azure-cli https://packages.microsoft.com/keys/microsoft.asc"
  assert_success
}
