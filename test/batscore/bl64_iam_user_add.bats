setup() {
  . "$DEVBL64_TEST_BASHLIB64"
  . "${DEVBL64_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-file/load.bash"
  set +u # to avoid IFS missing error in run function
}

@test "bl64_iam_user_add: function parameter missing" {
  run bl64_iam_user_add
  assert_equal "$status" $BL64_IAM_ERROR_MISSING_PARAMETER
  assert_output --partial "${_BL64_IAM_TXT_MISSING_PARAMETER}"
}

@test "bl64_iam_user_add: add regular user" {
  if [[ ! -f '/run/.containerenv' ]]; then
    skip 'this case can only be tested inside a container'
  fi
  run /usr/bin/sudo /bin/bash -c ". $DEVBL64_TEST_BASHLIB64 bl64_iam_user_add testusr"
}
