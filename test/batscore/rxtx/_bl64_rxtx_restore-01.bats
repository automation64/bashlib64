setup() {
  . "$DEVBL_TEST_SETUP"

  __bl64_rxtx_restore_destination="$(mktemp -d)"
  export __bl64_rxtx_restore_destination
}

teardown() {

  [[ -d "$__bl64_rxtx_restore_destination" ]] && rm -Rf "$__bl64_rxtx_restore_destination"

}

@test "_bl64_rxtx_restore: restore + result ok" {

  sample="${DEVBL_SAMPLES}/text_01.txt"
  test_file="${__bl64_rxtx_restore_destination}/org"
  cat "$sample" > "$test_file"

  test_bkp="${__bl64_rxtx_restore_destination}/org${_BL64_RXTX_BACKUP_POSTFIX}"
  cat "${DEVBL_SAMPLES}/text_02.txt" > "$test_bkp"

  run _bl64_rxtx_restore "$test_file" "$BL64_LIB_VAR_OK"
  assert_success

  assert_not_exists "$test_bkp"
  assert_exists "$test_file"

  run diff "$sample" "$test_file"
  assert_success

}
