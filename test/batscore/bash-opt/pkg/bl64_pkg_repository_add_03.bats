@test "bl64_pkg_repository_add: debian add" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_os_match "${BL64_OS_DEB}" "${BL64_OS_UB}" || skip 'Debian based only'
  bl64_cnt_is_inside_container || skip 'test-case for container mode'
  run $BL64_RBAC_ALIAS_SUDO_ENV /usr/bin/env bash -c \
    "source $DEV_TEST_BASHLIB64; bl64_pkg_setup; bl64_pkg_repository_add ghcli https://cli.github.com/packages https://cli.github.com/packages/githubcli-archive-keyring.gpg stable main"
  assert_success
}
