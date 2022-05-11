setup() {
  . "$DEVBL_TEST_SETUP"

}

@test "bl64_rbac_check_sudoers: check ok" {
  run bl64_rbac_check_sudoers "${DEVBL_SAMPLES}/sudoers/sudoers_01"
  assert_success
}

@test "bl64_rbac_check_sudoers: check not ok" {
  run bl64_rbac_check_sudoers "${DEVBL_SAMPLES}/sudoers/sudoers_02"
  assert_failure
}
