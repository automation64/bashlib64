setup() {
  . "$DEVBL_TEST_SETUP"

  _bl64_fs_restore_destination="$(mktemp -d)"
  export _bl64_fs_restore_destination
}

teardown() {

  [[ -d "$_bl64_fs_restore_destination" ]] && rm -Rf "$_bl64_fs_restore_destination"

}

@test "bl64_fs_restore: restore + result not ok + restore ok" {

  test_file="${_bl64_fs_restore_destination}/org"
  cat "${DEVBL_SAMPLES}/text_02.txt" > "$test_file"

  sample="${DEVBL_SAMPLES}/text_01.txt"
  test_bkp="${_bl64_fs_restore_destination}/org${BL64_FS_SAFEGUARD_POSTFIX}"
  cat "$sample" > "$test_bkp"

  run bl64_fs_restore "$test_file" "1"
  assert_success

  assert_not_exists "$test_bkp"
  assert_exists "$test_file"

  run diff "$sample" "$test_file"
  assert_success

}
