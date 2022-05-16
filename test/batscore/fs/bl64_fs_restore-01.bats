setup() {
  . "$DEVBL_TEST_SETUP"

  _bl64_fs_restore_destination="$(mktemp -d)"
  export _bl64_fs_restore_destination
}

teardown() {

  [[ -d "$_bl64_fs_restore_destination" ]] && rm -Rf "$_bl64_fs_restore_destination"

}

@test "bl64_fs_restore: restore + result ok" {

  sample="${DEVBL_SAMPLES}/text_01.txt"
  test_file="${_bl64_fs_restore_destination}/org"
  cat "$sample" > "$test_file"

  test_bkp="${_bl64_fs_restore_destination}/org${BL64_FS_SAFEGUARD_POSTFIX}"
  cat "${DEVBL_SAMPLES}/text_02.txt" > "$test_bkp"

  run bl64_fs_restore "$test_file" "$BL64_LIB_VAR_OK"
  assert_success

  assert_not_exists "$test_bkp"
  assert_exists "$test_file"

  run diff "$sample" "$test_file"
  assert_success

}
