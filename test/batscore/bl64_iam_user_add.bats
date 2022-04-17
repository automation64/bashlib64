setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"
}

@test "bl64_iam_user_add: function parameter missing" {
  set +u # to avoid IFS missing error in run function
  run bl64_iam_user_add
  assert_failure
}

@test "bl64_iam_user_add: add regular user" {
  if [[ ! -f '/run/.containerenv' ]]; then
    skip 'this case can only be tested inside a container'
  fi
  set +u # to avoid IFS missing error in run function
  run $BL64_RBAC_ALIAS_SUDO_ENV /bin/bash -c "source $DEVBL_TEST_BASHLIB64; bl64_iam_user_add testusr"
  assert_success
}
