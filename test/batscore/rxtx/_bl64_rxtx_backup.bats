setup() {
  . "$DEVBL_TEST_SETUP"

  __bl64_rxtx_backup_destination="$(mktemp -d)"
  export __bl64_rxtx_backup_destination
}

teardown() {

  [[ -d "$__bl64_rxtx_backup_destination" ]] && rm -Rf "$__bl64_rxtx_backup_destination"

}

@test "_bl64_rxtx_backup: backup" {

  test_file="${__bl64_rxtx_backup_destination}/org"
  cat "${DEVBL_SAMPLES}/text_01.txt" > "$test_file"

  run _bl64_rxtx_backup "$test_file"
  assert_success

  assert_not_exists "$test_file"
  assert_exists "${test_file}${_BL64_RXTX_BACKUP_POSTFIX}"

}
