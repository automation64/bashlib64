setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_rbac_run_command: run ok" {
  if [[ ! -f '/run/.containerenv' ]]; then
    skip 'this case can only be tested inside a container'
  fi
  set +u # to avoid IFS missing error in run function
  run bl64_rbac_run_command "$BL64_OS_CMD_TRUE"
  assert_success
}

@test "bl64_rbac_run_command: run error" {
  if [[ ! -f '/run/.containerenv' ]]; then
    skip 'this case can only be tested inside a container'
  fi
  set +u # to avoid IFS missing error in run function
  run bl64_rbac_run_command "$BL64_OS_CMD_FALSE"
  assert_failure
}
