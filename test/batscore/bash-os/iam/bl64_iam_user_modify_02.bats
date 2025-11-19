@test "bl64_iam_user_modify: modify user" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_is_inside_container || skip 'test-case for container mode'

  case "$BL64_OS_DISTRO" in
  ${BL64_OS_ARC}-*) : ;;
  ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*) : ;;
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*) : ;;
  ${BL64_OS_SLES}-*) : ;;
  *) skip 'test-case not supported in current os' ;;
  esac

  bl64_iam_setup
  $BL64_RBAC_ALIAS_SUDO_ENV /usr/bin/env bash -c "source $DEV_TEST_BASHLIB64; bl64_iam_user_add testusr"
  run $BL64_RBAC_ALIAS_SUDO_ENV /usr/bin/env bash -c "source $DEV_TEST_BASHLIB64; bl64_iam_user_modify testusr $BL64_VAR_DEFAULT /bin/sh"
  assert_success
}
