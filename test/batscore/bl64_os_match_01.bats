setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"
}

@test "bl64_os_match: fail os = ALM" {

  set +u # to avoid IFS missing error in run function
  export BL64_OS_DISTRO="${BL64_OS_ALM}-8.5"
  run bl64_os_match 'CNT'
  assert_failure
  assert_equal $status $BL64_OS_ERROR_NO_OS_MATCH

}

@test "bl64_os_match: invalid os = XXX" {

  set +u # to avoid IFS missing error in run function
  export BL64_OS_DISTRO="${BL64_OS_ALM}-8.5"
  run bl64_os_match 'XXX'
  assert_failure
  assert_equal $status $BL64_OS_ERROR_INVALID_OS_TAG

}

@test "bl64_os_match: os = ALP" {

  set +u # to avoid IFS missing error in run function
  export BL64_OS_DISTRO="${BL64_OS_ALP}-3.0"
  run bl64_os_match 'ALP'
  assert_success

}

@test "bl64_os_match: os = CNT" {

  set +u # to avoid IFS missing error in run function
  export BL64_OS_DISTRO="${BL64_OS_CNT}-8.5"
  run bl64_os_match 'CNT'
  assert_success

}

@test "bl64_os_match: os = DEB" {

  set +u # to avoid IFS missing error in run function
  export BL64_OS_DISTRO="${BL64_OS_DEB}-10.0"
  run bl64_os_match 'DEB'
  assert_success

}

@test "bl64_os_match: os = FD" {

  set +u # to avoid IFS missing error in run function
  export BL64_OS_DISTRO="${BL64_OS_FD}-33.0"
  run bl64_os_match 'FD'
  assert_success

}

@test "bl64_os_match: os = OL" {

  set +u # to avoid IFS missing error in run function
  export BL64_OS_DISTRO="${BL64_OS_OL}-8.5"
  run bl64_os_match 'OL'
  assert_success

}

@test "bl64_os_match: os = RHEL" {

  set +u # to avoid IFS missing error in run function
  export BL64_OS_DISTRO="${BL64_OS_RHEL}-8.5"
  run bl64_os_match 'RHEL'
  assert_success

}

@test "bl64_os_match: os = UB" {

  set +u # to avoid IFS missing error in run function
  export BL64_OS_DISTRO="${BL64_OS_UB}-20.4"
  run bl64_os_match 'UB'
  assert_success

}
