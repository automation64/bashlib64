setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"
}

@test "bl64_os_match: os = ALM-8" {

  set +u # to avoid IFS missing error in run function
  export BL64_OS_DISTRO="${BL64_OS_ALM}-8.5"
  run bl64_os_match 'ALM-8'
  assert_success

}

@test "bl64_os_match: os = ALM-8.5" {

  set +u # to avoid IFS missing error in run function
  export BL64_OS_DISTRO="${BL64_OS_ALM}-8.5"
  run bl64_os_match 'ALM-8.5'
  assert_success

}

@test "bl64_os_match: fail os = ALM-9" {

  set +u # to avoid IFS missing error in run function
  export BL64_OS_DISTRO="${BL64_OS_ALM}-8.5"
  run bl64_os_match 'ALM-9'
  assert_failure
  assert_equal $status $BL64_OS_ERROR_NO_OS_MATCH

}

@test "bl64_os_match: fail os = ALM-9.5" {

  set +u # to avoid IFS missing error in run function
  export BL64_OS_DISTRO="${BL64_OS_ALM}-8.5"
  run bl64_os_match 'ALM-9.5'
  assert_failure
  assert_equal $status $BL64_OS_ERROR_NO_OS_MATCH

}
